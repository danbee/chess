import Immutable from "immutable";

import defaultState from "../store/default-state";

const chessBoardReducer = (state = defaultState, action) => {
  switch (action.type) {
    case "SET_USER_ID":
      return Immutable.fromJS(state)
        .set("userId", action.user_id)
        .toJS();

    case "SET_PLAYERS":
      return Immutable.fromJS(state)
        .set("player", action.player)
        .set("playerId", action.player_id)
        .set("opponent", action.opponent)
        .set("opponentId", action.opponent_id)
        .toJS();

    case "SET_GAME":
      return Immutable.fromJS(state)
        .set("board", action.board)
        .set("turn", action.turn)
        .set("state", action.state)
        .set("selectedSquare", null)
        .set("availableMoves", [])
        .set("moves", action.moves)
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
        .set("availableMoves", [])
        .toJS();

    case "SET_OPPONENT_STATUS":
      return Immutable.fromJS(state)
        .set("opponentStatus", action.opponentStatus)
        .toJS();

    default:
      return state;
  }
};

export default chessBoardReducer;
