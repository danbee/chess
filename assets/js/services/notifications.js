class Notifications {
  constructor() {
    if (this.notifications_available) {
      Notification.requestPermission();
    }
  }

  notifyTurn(player) {
    this.notify({
      body: "Your opponent has moved.",
      icon: `/images/king_${player}.svg`,
    });
  }

  notify(options) {
    if (this.notifications_available && !document.hasFocus()) {
      new Notification("Chess", options);
    }
  }

  get notifications_available() {
    window.Notification != undefined;
  }
}

export default Notifications;
