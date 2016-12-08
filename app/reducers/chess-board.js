import defaultState from "store/default-state";

const chessBoardReducer = (state = defaultState, action) => {
  switch (action.type) {
    case "MOVE_PIECE":
      var piece = state.board[from.rank][from.file];
      state.board[to.rank][to.file] = piece;
      state.board[from.rank][from.file] = null;
      return state;

      var newBoard = state.board.map((item, index) => {
      });
      return Object.assign({}, state, {
        board: newBoard
      });

    case "SELECT_PIECE":
      console.log("Action fired");
      return Object.assign({}, state, { selectedSquare: action.coords });

    default:
      return state;
  }
}

export default chessBoardReducer;
