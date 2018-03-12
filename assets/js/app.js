"use strict";

import "babel-polyfill";
import "phoenix_html";

import React from "react";
import ReactDOM from "react-dom";
import { createStore } from "redux";
import { Provider } from "react-redux";

import Channel from "./services/channel";

import chessBoardReducer from "./reducers/chess-board";
import { setGameId } from "./store/actions";

import ChessBoard from "./components/chess-board";

const store = createStore(chessBoardReducer);

class App extends React.Component {
  componentWillMount() {
    const { gameId, store } = this.props;

    store.dispatch(setGameId(gameId));

    this.channel = new Channel(store, gameId);
  }

  render() {
    const { store, gameId } = this.props;

    return (
      <ChessBoard
        gameId={gameId}
        store={store}
        channel={this.channel}
      />
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
