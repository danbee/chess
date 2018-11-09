import _ from "lodash";
import socket from "./socket";
import { Presence } from "phoenix";
import {
  setUserId,
  setPlayers,
  setGame,
  setAvailableMoves,
  setOpponentStatus,
} from "../store/actions";

class Channel {
  constructor(store, gameId) {
    this.store = store;
    this.channel = socket.channel(`game:${gameId}`, {});
    this.presence = new Presence(this.channel);

    this.join();
    this.subscribe();
  }

  get opponentId() {
    return this.store.getState().opponentId;
  }

  join() {
    this.channel
      .join()
      .receive("error", resp => {
        console.log("Unable to join", resp);
      });
  }

  leave() {
    this.channel.leave();
  }

  subscribe() {
    this.channel.on("game:update", this.updateGame.bind(this));

    this.presence.onSync(() => { this.setOpponentStatus(); });
  }

  updateGame(data) {
    if (data.player != undefined) {
      this.store.dispatch(setUserId(data.user_id));
      this.store.dispatch(setPlayers(data));
    }
    this.store.dispatch(setGame(data));
  }

  setOpponentStatus() {
    this.store.dispatch(
      setOpponentStatus(
        this.opponentOnline(this.opponentId) ? "viewing" : "offline"
      )
    );
  }

  opponentOnline(opponentId) {
    return _.find(
      this.presence.list(),
      ({ metas: [user, ...rest] }, id) => {
        return parseInt(user.id) == opponentId;
      }
    );
  }

  getAvailableMoves(square) {
    this.channel
      .push("game:get_available_moves", { square })
      .receive("ok", data => {
        this.store.dispatch(setAvailableMoves(data.moves));
      });
  }

  sendMove(move) {
    this.channel
      .push("game:move", move)
      .receive("error", resp => {
        alert(resp.message);
      });
  }
}

export default Channel;
