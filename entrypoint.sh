#!/bin/bash

mix deps.get
# mix deps.compile

mix ecto.create
mix ecto.migrate
iex --sname main@localhost --cookie main -S mix phx.server