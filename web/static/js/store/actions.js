const SET_BOARD = "SET_BOARD";
const SET_GAME_ID = "SET_GAME_ID";
const SELECT_PIECE = "SELECT_PIECE";
const MOVE_PIECE = "MOVE_PIECE";

export const setBoard = (board) => {
  return {
    type: SET_BOARD,
    board: board
  }
}

export const setGameId = (gameId) => {
  return {
    type: SET_GAME_ID,
    gameId: gameId
  }
}

export const selectPiece = (coords) => {
  return {
    type: SELECT_PIECE,
    coords: coords
  };
}

export const movePiece = (from, to) => {
  return {
    type: MOVE_PIECE,
    from: from,
    to: to
  };
}
