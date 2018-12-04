import _ from "lodash";
import socket from "./socket";
import Presences from "./presences";
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
    this.presences = new Presences();

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

    this.channel.on("presence_state", data => {
      this.presences.syncState(data);
      this.setOpponentStatus();
    });

    this.channel.on("presence_diff", data => {
      this.presences.syncDiff(data);
      this.setOpponentStatus();
    });
  }

  updateGame(data) {
    if (data.player !== undefined) {
      this.store.dispatch(setUserId(data.user_id));
      this.store.dispatch(setPlayers(data));
    }
    this.store.dispatch(setGame(data));
  }

  setOpponentStatus() {
    this.store.dispatch(
      setOpponentStatus(
        this.presences.opponentOnline(this.opponentId) ? "viewing" : "offline"
      )
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
