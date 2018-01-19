"use strict";

import "babel-polyfill";
import "phoenix_html"

import React from "react";
import ReactDOM from "react-dom";
import { createStore } from "redux";
import { Provider } from "react-redux";

import chessBoardReducer from "./reducers/chess-board";

const store = createStore(chessBoardReducer);

import ChessBoard from "./components/chess-board";

class App extends React.Component {
  render() {
    const { store, gameId } = this.props;

    return (
      <ChessBoard gameId={gameId} store={store} />
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
