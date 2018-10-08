"use strict";

import "phoenix_html";

import React from "react";
import ReactDOM from "react-dom";

import Channel from "../services/channel";
import Notifications from "../services/notifications";

import { setGameId } from "../store/actions";
import Listeners from "../store/listeners";

import ChessBoard from "./chess-board";
import MoveList from "./move-list";
import GameInfo from "./game-info";

const notifications = new Notifications();

class Game extends React.Component {
  componentWillMount() {
    const { gameId, store } = this.props;

    store.dispatch(setGameId(gameId));

    this.listeners = new Listeners(store);
    this.listeners.setListeners(notifications);

    this.channel = new Channel(store, gameId);
  }

  componentWillUnmount() {
    this.channel.leave();
  }

  get moves() {
    const { store } = this.props;
    return store.getState().moves;
  }

  get opponent() {
    const { store } = this.props;
    return store.getState().opponent;
  }

  render() {
    const { store, gameId } = this.props;

    return (
      <div className="game-grid">
        <ChessBoard
          gameId={gameId}
          store={store}
          channel={this.channel}
        />

        <GameInfo store={store} />

        <MoveList store={store} />
      </div>
    );
  }
}

export default Game;
