const SET_PLAYER = "SET_PLAYER";
const SET_GAME = "SET_GAME";
const SET_GAME_ID = "SET_GAME_ID";
const SELECT_PIECE = "SELECT_PIECE";

export const setPlayer = (player) => {
  return {
    type: SET_PLAYER,
    player: player
  };
};

export const setGame = (data) => {
  return {
    type: SET_GAME,
    board: data.board,
    turn: data.turn
  };
};

export const setGameId = (gameId) => {
  return {
    type: SET_GAME_ID,
    gameId: gameId
  };
};

export const selectPiece = (coords) => {
  return {
    type: SELECT_PIECE,
    coords: coords
  };
};
