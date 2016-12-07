import React from "react";

import defaultState from "store/default_state";

import ChessBoardSquare from "components/chess-board-square";

class ChessBoard extends React.Component {
  constructor(props) {
    super(props);
    this.state = defaultState;
  }

  chessBoardRow(row, i) {
    return (
      <div className="board-row" key={i}>
        {row.map(
          (square, j) => <ChessBoardSquare key={j} square={square} />
        )}
      </div>
    )
  }

  render() {
    return (
      <div className="board">
        {this.state.board.map((row, i) => this.chessBoardRow(row, i))}
      </div>
    );
  }
}

export default ChessBoard;
