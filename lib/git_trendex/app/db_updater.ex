defmodule GitTrendex.App.DbUpdater do
  use GenServer

  require GitTrendex.Pact

  alias GitTrendex.Pact, as: Pact

  defmodule State do
    @type t :: %State{
            last_update: pos_integer() | nil,
            updating: boolean(),
            timer: reference() | nil,
            timeout: integer() | nil
          }
    defstruct [:last_update, :updating, :timer, :timeout]
  end

  ############
  ## INTERFACE
  ############

  @spec get_last_updated_time :: pos_integer()
  def get_last_updated_time() do
    GenServer.call(__MODULE__, :last_update)
  end

  @spec update(State.t()) :: State.t()
  def update(%State{timeout: nil} = state) do
    state
  end

  def update(%State{timeout: timeout, timer: timer} = state) do
    stop_timer(timer)

    Pact.app_api().sync()

    new_timer = Process.send_after(self(), :update, timeout)

    %State{state | timer: new_timer, last_update: :os.system_time()}
  end

  ############
  ## GENSERVER
  ############

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(opts) do
    timeout = Keyword.get(opts, :timeout, nil)

    state = %State{last_update: nil, updating: false, timer: nil, timeout: timeout}
    {:ok, state, {:continue, timeout}}
  end

  def handle_call(:last_update, _from, %State{last_update: last_update} = state) do
    {:reply, last_update, state}
  end

  def handle_info(:update, %State{} = state) do
    new_state = update(state)
    {:noreply, new_state}
  end

  @spec handle_continue(reference() | nil, State.t()) :: {:noreply, State.t()}
  def handle_continue(nil, state) do
    {:noreply, state}
  end

  def handle_continue(_, state) do
    new_state = update(state)
    {:noreply, new_state}
  end

  ##########
  ## PRIVATE
  ##########

  defp stop_timer(nil), do: false
  defp stop_timer(ref), do: Process.cancel_timer(ref)
end
