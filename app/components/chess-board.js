import React from "react";

import defaultState from "store/default_state";

import ChessBoardSquare from "components/chess-board-square";

class ChessBoard extends React.Component {
  constructor(props) {
    super(props);
    this.state = defaultState;
  }

  chessBoardRow(row) {
    return (
      <div className="board-row">
        {row.map((square) => <ChessBoardSquare square={square} />)}
      </div>
    )
  }

  render() {
    return (
      <div className="board">
        {this.state.board.map((row) => this.chessBoardRow(row))}
      </div>
    );
  }
}

export default ChessBoard;
