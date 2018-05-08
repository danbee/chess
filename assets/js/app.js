"use strict";

import "babel-polyfill";
import "phoenix_html";

import React from "react";
import ReactDOM from "react-dom";
import { createStore } from "redux";

import Channel from "./services/channel";

import chessBoardReducer from "./reducers/chess-board";
import { setGameId } from "./store/actions";

import ChessBoard from "./components/chess-board";
import MoveList from "./components/move-list";

const store = createStore(chessBoardReducer);

class App extends React.Component {
  componentWillMount() {
    const { gameId, store } = this.props;

    store.dispatch(setGameId(gameId));

    this.channel = new Channel(store, gameId);
  }

  get moves() {
    const { store } = this.props;
    return store.getState().moves;
  }

  render() {
    const { store, gameId } = this.props;

    return (
      <div>
        <ChessBoard
          gameId={gameId}
          store={store}
          channel={this.channel}
        />

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
