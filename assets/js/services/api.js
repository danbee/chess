import axios from "axios";

const API = {
  findOpponent: (queryString) => {
    return axios.get("/api/opponents", { params: { q: queryString } });
  },
};

export default API;
