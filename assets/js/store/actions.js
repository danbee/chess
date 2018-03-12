const SET_PLAYER = "SET_PLAYER";
const SET_GAME = "SET_GAME";
const SET_MOVES = "SET_MOVES";
const SET_GAME_ID = "SET_GAME_ID";
const SELECT_PIECE = "SELECT_PIECE";

export const setPlayer = (player) => {
  return {
    type: SET_PLAYER,
    player,
  };
};

export const setGame = (data) => {
  return {
    type: SET_GAME,
    board: data.board,
    turn: data.turn,
  };
};

export const setMoves = (moves) => {
  return {
    type: SET_MOVES,
    moves,
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
