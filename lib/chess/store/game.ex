defmodule Chess.Store.Game do
  @moduledoc false

  use Ecto.Schema
  use Timex.Ecto.Timestamps

  import Ecto.Changeset
  import Ecto.Query
  import ChessWeb.Gettext

  alias Chess.Board
  alias Chess.GameState
  alias Chess.Store.Game
  alias Chess.Store.Move
  alias Chess.Store.User

  schema "games" do
    field :board, :map, default: Board.default()
    field :turn, :string, default: "white"
    field :state, :string

    belongs_to :user, User
    belongs_to :opponent, User, references: :id

    has_many :moves, Move

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, required_attrs())
    |> validate_required(required_attrs())
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:opponent_id)
  end

  def move_changeset(struct, params) do
    struct
    |> cast(params, required_attrs())
    |> validate_king_in_check(struct, params)
    |> change_turn(struct.turn)
    |> check_game_state
  end

  def change_turn(changeset, turn) do
    changeset
    |> put_change(:turn, _change_turn(turn))
  end

  def _change_turn("black"), do: "white"
  def _change_turn("white"), do: "black"

  def for_user(query, user) do
    for_user_id(query, user.id)
  end

  def for_user_id(query, user_id) do
    from game in query,
      where: game.user_id == ^user_id,
      or_where: game.opponent_id == ^user_id
  end

  def check_game_state(changeset) do
    changeset
    |> put_change(
      :state, GameState.state(changeset.changes.board, changeset.changes.turn)
    )
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

  def ordered(query) do
    query
    |> order_by([game], desc: game.inserted_at)
  end

  defp required_attrs, do: ~w[board turn user_id opponent_id]a
end
