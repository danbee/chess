"use strict";

import React from "react";
import ReactDOM from "react-dom";
import { createStore } from "redux";
import { Provider } from "react-redux";

import chessBoardReducer from "./reducers/chess-board";

const store = createStore(chessBoardReducer);

import ChessBoard from "./components/chess-board";

class App extends React.Component {
  render() {
    const { store } = this.props;

    return (
      <ChessBoard store={store} />
    );
  }
}

ReactDOM.render(
  <App store={store} />,
  document.getElementById('app')
);
