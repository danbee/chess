import React from "react";

import ChessBoardSquare from "components/chess-board-square";

class ChessBoard extends React.Component {
  constructor(props) {
    super(props);
  }

  chessBoardRows() {
    const { store } = this.props;
    return store.getState().board;
  }

  chessBoardRow(row, i) {
    return (
      <div className="board-rank" key={i}>
        {row.map(
          (square, j) => (
            <ChessBoardSquare key={j} rank={i} file={j} square={square} />
          )
        )}
      </div>
    )
  }

  render() {
    return (
      <div className="board">
        {this.chessBoardRows().map((row, i) => this.chessBoardRow(row, i))}
      </div>
    );
  }
}

export default ChessBoard;
