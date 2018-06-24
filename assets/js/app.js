"use strict";

import "babel-polyfill";
import "phoenix_html";

import React from "react";
import ReactDOM from "react-dom";
import { createStore } from "redux";

import Channel from "./services/channel";
import Notifications from "./services/notifications";

import chessBoardReducer from "./reducers/chess-board";
import { setGameId } from "./store/actions";
import Listeners from "./store/listeners";

import ChessBoard from "./components/chess-board";
import MoveList from "./components/move-list";
import GameInfo from "./components/game-info";

const store = createStore(chessBoardReducer);
const notifications = new Notifications();

class App extends React.Component {
  componentWillMount() {
    const { gameId, store } = this.props;

    store.dispatch(setGameId(gameId));

    this.listeners = new Listeners(store);
    this.listeners.setListeners(notifications);

    this.channel = new Channel(store, gameId);
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

const container = document.getElementById("app");

if (container != undefined) {
  const gameId = container.getAttribute("data-game-id");

  ReactDOM.render(
    <App store={store} gameId={gameId} />,
    container
  );
}
