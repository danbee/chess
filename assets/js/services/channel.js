import socket from "../socket";
import { setPlayer, setGame } from "../store/actions";

class Channel {
  constructor(store, gameId) {
    this.store = store;
    this.channel = socket.channel(`game:${gameId}`, {});

    this.join();
    this.subscribe();
  }

  join() {
    this.channel.join()
      .receive("error", resp => {
        console.log("Unable to join", resp);
      });
  }

  subscribe() {
    this.channel.on("game:update", data => {
      if (data.player != undefined) {
        this.store.dispatch(setPlayer(data.player));
      };
      this.store.dispatch(setGame(data));
    });
  }

  sendMove(move) {
    this.channel.push("game:move", move);
  }
}

export default Channel;
