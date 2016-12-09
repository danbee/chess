import defaultState from "../store/default-state";
import movePiece from "./move-piece";

const chessBoardReducer = (state = defaultState, action) => {
  switch (action.type) {
    case "MOVE_PIECE":
      const newState = {
        board: movePiece(state.board, action.from, action.to),
        selectedSquare: null
      }

      return Object.assign({}, state, newState);

    case "SELECT_PIECE":
      return Object.assign({}, state, { selectedSquare: action.coords });

    default:
      return state;
  }
}

export default chessBoardReducer;
