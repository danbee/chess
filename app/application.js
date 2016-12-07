"use strict";

import React from "react";
import ReactDOM from "react-dom";

import ChessBoard from "components/chess-board";

class App extends React.Component {
  render() {
    return (
      <ChessBoard />
    );
  }
}

ReactDOM.render(
  <App />,
  document.getElementById('app')
);
