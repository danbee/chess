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

  def select_opponent(session, name) do
    session
    |> fill_in(text_field("Find opponent"), with: name)
    |> click(link(name))
  end
end
