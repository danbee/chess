import _ from "lodash";
import { Presence } from "phoenix";

class Presences {
  constructor() {
    this.presences = {};
  }

  syncState(data) {
    this.presences = Presence.syncState(this.presences, data);
  }

  syncDiff(data) {
    this.presences = Presence.syncDiff(this.presences, data);
  }

  opponentOnline(opponentId) {
    return _.find(this.presences, (value, id) => {
      return parseInt(id) == opponentId;
    });
  }
}

export default Presences;
