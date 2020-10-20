defmodule GitTrendex.App.DbUpdater do
  use GenServer

  require GitTrendex.Pact
  require Logger

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

  @spec restart_timer :: any
  def restart_timer() do
    Kernel.send(__MODULE__, :restart_timer)
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

  def handle_info(:restart_timer, %State{} = state) do
    new_timer = do_restart_timer(state)

    {:noreply, %State{state | timer: new_timer}}
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

  @spec update(State.t()) :: State.t()
  defp update(%State{timeout: nil} = state) do
    state
  end

  defp update(%State{} = state) do
    new_timer = do_restart_timer(state)

    Pact.app_api().sync()

    %State{state | timer: new_timer, last_update: :os.system_time()}
  end

  defp do_restart_timer(%State{timeout: timeout, timer: timer}) do
    Logger.info("restarting timer")
    stop_timer(timer)
    Process.send_after(self(), :update, timeout)
  end

  defp stop_timer(nil), do: false
  defp stop_timer(ref) do
    Process.cancel_timer(ref)
  end
end
