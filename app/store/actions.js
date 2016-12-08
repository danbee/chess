const SELECT_PIECE = "SELECT_PIECE";
const MOVE_PIECE = "MOVE_PIECE";

export const selectPiece = (coords) => {
  return {
    type: selectPiece,
    coords: coords
  };
}

export const movePiece = (from, to) => {
  return {
    type: movePiece,
    from: from,
    to: to
  };
}
