import axios from "axios";

const API = {
  getGame: (gameId) => {
    return axios.get(`/api/games/${gameId}`);
  },

  updateGame: (gameId, move) => {
    return axios.patch(`/api/games/${gameId}`, { move });
  },
};

export default API;
