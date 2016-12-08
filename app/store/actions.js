const SELECT_PIECE = "SELECT_PIECE";
const MOVE_PIECE = "MOVE_PIECE";

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
