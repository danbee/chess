import defaultState from "store/default-state";

const chessBoardReducer = (state = defaultState, action) => {
  switch (action.type) {
    case "MOVE_PIECE":
      var piece = state.board[from.rank][from.file];
      state.board[to.rank][to.file] = piece;
      state.board[from.rank][from.file] = null;
      return state;

    case "SELECT_PIECE":
      return Object.assign({}, state, { selectedSquare: action.coords });

    default:
      return state;
  }
}

export default chessBoardReducer;
