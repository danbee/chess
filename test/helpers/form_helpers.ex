defmodule Chess.FormHelpers do
  @moduledoc false

  use Wallaby.DSL

  import Wallaby.Query

  def select(session, name, [option: option]) do
    session
    |> find(css("[name='#{name}']"))
    |> click(option(option))

    session
  end
end
