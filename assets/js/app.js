"use strict";

import "babel-polyfill";
import "phoenix_html";

import React from "react";
import ReactDOM from "react-dom";
import watch from "redux-watch";
import { createStore } from "redux";

import Channel from "./services/channel";
import Notifications from "./services/notifications";

import chessBoardReducer from "./reducers/chess-board";
import { setGameId } from "./store/actions";

import ChessBoard from "./components/chess-board";
import MoveList from "./components/move-list";
import GameInfo from "./components/game-info";

const store = createStore(chessBoardReducer);
const notifications = new Notifications();

class App extends React.Component {
  componentWillMount() {
    const { gameId, store } = this.props;

    store.dispatch(setGameId(gameId));

    let w = watch(store.getState, "turn");
    store.subscribe(w((newVal, oldVal, objectPath) => {
      const player = store.getState().player;

      if (oldVal != null && newVal == player) {
        notifications.notifyTurn(player);
      }
    }));

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
