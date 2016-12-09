const SET_BOARD = "SET_BOARD";
const SELECT_PIECE = "SELECT_PIECE";
const MOVE_PIECE = "MOVE_PIECE";

export const setBoard = (board) => {
  return {
    type: SET_BOARD,
    board: board
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
