"use strict";

import "@babel/polyfill";
import "phoenix_html";

import React from "react";
import ReactDOM from "react-dom";
import { createStore } from "redux";

import Game from "./components/game";
import OpponentFinder from "./components/opponent-finder";
import chessBoardReducer from "./reducers/chess-board";

const store = createStore(chessBoardReducer);

const gameContainer = document.getElementById("game");

if (gameContainer != undefined) {
  const gameId = gameContainer.getAttribute("data-game-id");

  ReactDOM.render(
    <Game store={store} gameId={gameId} />,
    gameContainer
  );
}

const opponentFinderContainer = document.getElementById("opponent-finder");

if (opponentFinderContainer != undefined) {
  ReactDOM.render(
    <OpponentFinder store={store} />,
    opponentFinderContainer
  );
}
