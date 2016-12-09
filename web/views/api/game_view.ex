defmodule Chess.Api.GameView do
  use Chess.Web, :view

  def render("show.json", %{ id: 1 }) do
    %{ foo: :bar }
  end
end
