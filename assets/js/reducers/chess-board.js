import Immutable from "immutable";

import defaultState from "../store/default-state";

const chessBoardReducer = (state = defaultState, action) => {
  switch (action.type) {
    case "SET_BOARD":
      return Immutable.fromJS(state)
        .set("board", action.board)
        .set("selectedSquare", null)
        .toJS();

    case "SET_GAME_ID":
      return Immutable.fromJS(state)
        .set("gameId", action.gameId)
        .toJS();

    case "SELECT_PIECE":
      return Immutable.fromJS(state)
        .set("selectedSquare", action.coords)
        .toJS();

    default:
      return state;
  }
}

export default chessBoardReducer;
