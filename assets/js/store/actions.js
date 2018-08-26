const SET_USER_ID = "SET_USER_ID";
const SET_PLAYERS = "SET_PLAYERS";
const SET_GAME = "SET_GAME";
const SET_AVAILABLE_MOVES = "SET_AVAILABLE_MOVES";
const SET_GAME_ID = "SET_GAME_ID";
const SELECT_PIECE = "SELECT_PIECE";
const SET_OPPONENT_STATUS = "SET_OPPONENT_STATUS";

export const setUserId = (user_id) => {
  return {
    type: SET_USER_ID,
    user_id,
  };
};

export const setPlayers = (data) => {
  return {
    type: SET_PLAYERS,
    player: data.player,
    player_id: data.player_id,
    opponent: data.opponent,
    opponent_id: data.opponent_id,
  };
};

export const setGame = (data) => {
  return {
    type: SET_GAME,
    board: data.board,
    turn: data.turn,
    moves: data.moves,
    state: data.state,
  };
};

export const setAvailableMoves = (availableMoves) => {
  return {
    type: SET_AVAILABLE_MOVES,
    availableMoves,
  };
};

export const setGameId = (gameId) => {
  return {
    type: SET_GAME_ID,
    gameId,
  };
};

export const selectPiece = (coords) => {
  return {
    type: SELECT_PIECE,
    coords,
  };
};

export const setOpponentStatus = (opponentStatus) => {
  return {
    type: SET_OPPONENT_STATUS,
    opponentStatus,
  };
};
