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

  chessBoardRow(row, rank) {
    return (
      <div className="board-rank" key={rank}>
        {Object.keys(row).map(
          (file) => <ChessBoardSquare key={file} rank={rank} file={file} square={row[file]} />
        )}
      </div>
    )
  }

  render() {
    return (
      <div className="board">
        {Object.keys(this.chessBoardRows()).reverse().map(
          (rank) => this.chessBoardRow(this.chessBoardRows()[rank], rank)
        )}
      </div>
    );
  }
}

export default ChessBoard;
