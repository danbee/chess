const SET_PLAYER = "SET_PLAYER";
const SET_OPPONENT = "SET_OPPONENT";
const SET_GAME = "SET_GAME";
const SET_AVAILABLE_MOVES = "SET_AVAILABLE_MOVES";
const SET_GAME_ID = "SET_GAME_ID";
const SELECT_PIECE = "SELECT_PIECE";

export const setPlayer = (player) => {
  return {
    type: SET_PLAYER,
    player,
  };
};

export const setOpponent = (opponent) => {
  return {
    type: SET_OPPONENT,
    opponent,
  };
};

export const setGame = (data) => {
  return {
    type: SET_GAME,
    board: data.board,
    turn: data.turn,
    moves: data.moves,
    state: data.state,
  };
};

export const setAvailableMoves = (availableMoves) => {
  return {
    type: SET_AVAILABLE_MOVES,
    availableMoves,
  };
};

export const setGameId = (gameId) => {
  return {
    type: SET_GAME_ID,
    gameId,
  };
};

export const selectPiece = (coords) => {
  return {
    type: SELECT_PIECE,
    coords,
  };
};
