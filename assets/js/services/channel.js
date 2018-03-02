import socket from "../socket";

const Channel = {
  gameChannel: (gameId) => {
    const channel = socket.channel(`game:${gameId}`, {});

    channel.join()
      .receive("error", resp => {
        console.log("Unable to join", resp);
      });

    return channel;
  },
};

export default Channel;
