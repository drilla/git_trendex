defmodule GitTrendexWeb.PageControllerTest do
  use GitTrendexWeb.ConnCase

  @tag :integration
  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
