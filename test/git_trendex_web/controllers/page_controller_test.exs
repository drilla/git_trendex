defmodule GitTrendexWeb.PageControllerTest do
  use GitTrendexWeb.ConnCase, async: false
  alias Test.GitTrendex.Helpers.Db
  alias GitTrendex.Db.Repository

  @moduletag :integration
  @endpoint GitTrendexWeb.PageController

  setup do
    one = Db.add_repo(%Repository{id: 1, name: "1", desc: "desc1", owner: "owner1", stars: 1, stars_today: 1})
    two = Db.add_repo(%Repository{id: 2, name: "2", desc: "desc2", owner: "owner2", stars: 2, stars_today: 2})
    %{conn: build_conn(), items: [one, two], item: one }
  end

  test "GET /", %{conn: conn, items: items} do
    conn = get(conn, :index)
    assert json_response(conn, 200) == Jason.encode!(items) |> Jason.decode!()
  end

  test "GET by id", %{conn: conn, item: item} do
    conn = get(conn, :show, %{"id" => item.id})
    assert json_response(conn, 200) == Jason.encode!(item) |> Jason.decode!()
  end

  test "GET by name", %{conn: conn, item: item} do
    conn = get(conn, :show, %{"name" => item.name})
    assert json_response(conn, 200) == Jason.encode!(item) |> Jason.decode!()
  end

  test "sync", %{conn: conn} do
    conn = post(conn, :sync)
    assert json_response(conn, 200) == "ok"
  end
end
