class Notifications {
  constructor() {
    Notification.requestPermission();
  }

  notifyTurn(player) {
    if (!document.hasFocus()) {
      new Notification("Chess", {
        body: "Your opponent has moved.",
        icon: `/images/king_${player}.svg`
      });
    }
  }
}

export default Notifications;
