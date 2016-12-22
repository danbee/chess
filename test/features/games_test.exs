defmodule Chess.GamesTest do
  use Chess.FeatureCase

  test "visit homepage" do
    navigate_to "/"
    find_element(:css, "body")

    assert title_text == "Chess"
  end

  test "can create a new game" do
    navigate_to "/"
    create_game

    assert page_has_chess_board
  end

  defp create_game do
    click({:css, "form.create-game button[type='submit']"})
  end

  defp title_text do
    find_element(:css, "header h1") |> visible_text
  end

  defp page_has_chess_board do
    element_displayed?({:css, ".board"})
  end
end
