import Immutable from "immutable";

import defaultState from "../store/default-state";

const chessBoardReducer = (state = defaultState, action) => {
  switch (action.type) {
    case "SET_PLAYER":
      return Immutable.fromJS(state)
        .set("player", action.player)
        .toJS();

    case "SET_GAME":
      return Immutable.fromJS(state)
        .set("board", action.board)
        .set("turn", action.turn)
        .set("state", action.state)
        .set("selectedSquare", null)
        .set("moves", [])
        .toJS();

    case "SET_AVAILABLE_MOVES":
      return Immutable.fromJS(state)
        .set("availableMoves", action.availableMoves)
        .toJS();

    case "SET_GAME_ID":
      return Immutable.fromJS(state)
        .set("gameId", action.gameId)
        .toJS();

    case "SELECT_PIECE":
      return Immutable.fromJS(state)
        .set("selectedSquare", action.coords)
        .set("moves", [])
        .toJS();

    default:
      return state;
  }
};

export default chessBoardReducer;
