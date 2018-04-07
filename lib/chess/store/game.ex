defmodule Chess.Store.Game do
  @moduledoc false

  use Ecto.Schema
  use Timex.Ecto.Timestamps

  import Ecto.Changeset
  import Ecto.Query
  import ChessWeb.Gettext

  alias Chess.Board
  alias Chess.Store.Game
  alias Chess.GameState

  schema "games" do
    field :board, :map, default: Board.default()
    field :turn, :string, default: "white"
    field :state, :string

    belongs_to :user, Chess.Store.User
    belongs_to :opponent, Chess.Store.User, references: :id

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, required_attrs())
    |> validate_required(required_attrs())
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:opponent_id)
  end

  def move_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, required_attrs())
    |> validate_king_in_check(struct, params)
    |> check_game_state(struct, params)
  end

  def change_turn("black"), do: "white"
  def change_turn("white"), do: "black"

  def for_user(user) do
    for_user_id(user.id)
  end

  def for_user_id(user_id) do
    from game in Game,
      where: game.user_id == ^user_id,
      or_where: game.opponent_id == ^user_id
  end

  def check_game_state(changeset, _struct, params) do
    changeset
    |> put_change(:state, GameState.state(params.board, params.turn))
  end

  def validate_king_in_check(changeset, %Game{turn: turn}, %{board: board}) do
    if GameState.king_in_check?(board, turn) do
      changeset
      |> add_error(
        :board,
        gettext("That move would leave your king in check")
      )
    else
      changeset
    end
  end
  def validate_king_in_check(changeset, _, _), do: changeset

  def game_over?(game) do
    game.state == "checkmate" ||
      game.state == "stalemate"
  end

  def ordered(query) do
    query
    |> order_by([game], desc: game.inserted_at)
  end

  defp required_attrs, do: ~w[board turn user_id opponent_id]a
end
