defmodule Chess.FormHelpers do
  use Wallaby.DSL

  import Wallaby.Query

  def select(session, name, [option: option]) do
    session
    |> find(css("[name='#{name}']"))
    |> click(option(option))

    session
  end
end
