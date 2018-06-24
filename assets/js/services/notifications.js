class Notifications {
  constructor() {
    Notification.requestPermission();
  }

  notifyTurn(player) {
    this.notify({
      body: "Your opponent has moved.",
      icon: `/images/king_${player}.svg`,
    });
  }

  notify(options) {
    if (!document.hasFocus()) {
      new Notification("Chess", options);
    }
  }
}

export default Notifications;
