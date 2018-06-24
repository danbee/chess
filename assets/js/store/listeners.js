import watch from "redux-watch";

class Listeners {
  constructor(store) {
    this.store = store;
  }

  setListeners(notifications) {
    this.notifications = notifications;

    let watcher = watch(this.store.getState, "turn");

    this.store.subscribe(
      watcher(this.notifyTurn.bind(this))
    );
  }

  notifyTurn(newVal, oldVal) {
    const player = this.store.getState().player;

    if (oldVal != null && newVal == player) {
      this.notifications.notifyTurn(player);
    }
  }
};

export default Listeners;
