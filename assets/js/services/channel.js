import socket from "../socket";

const Channel = {
  gameChannel: (gameId) => {
    const channel = socket.channel(`game:${gameId}`, {});

    return channel;
  },
};

export default Channel;
