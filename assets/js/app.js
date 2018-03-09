"use strict";

import "babel-polyfill";
import "phoenix_html";

import React from "react";
import ReactDOM from "react-dom";
import { createStore } from "redux";
import { Provider } from "react-redux";

import chessBoardReducer from "./reducers/chess-board";

const store = createStore(chessBoardReducer);

import { setPlayer, setGame, setGameId } from "./store/actions";

import API from "./services/api";
import Channel from "./services/channel";

import ChessBoard from "./components/chess-board";

class App extends React.Component {
  componentWillMount() {
    const { gameId, store } = this.props;

    store.dispatch(setGameId(gameId));

    API.getGame(gameId)
      .then(response => {
        store.dispatch(setPlayer(response.data.player));
        store.dispatch(setGame(response.data));
      });

    this.channel = Channel.gameChannel(gameId);

    this.channel.on("game_update", data => {
      store.dispatch(setGame(data));
    });
  }

  sendMove(gameId, move) {
    API.updateGame(gameId, move);
  }

  render() {
    const { store, gameId } = this.props;

    return (
      <ChessBoard gameId={gameId} store={store} sendMove={this.sendMove} />
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
