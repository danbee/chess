import React from "react";
import { connect } from "react-redux";

import ChessBoardSquare from "components/chess-board-square";

class ChessBoard extends React.Component {
  getBoard() {
    const { store } = this.props;
    return store.getState().board;
  }

  renderFiles(rankId) {
    const { store } = this.props;
    const rank = this.getBoard()[rankId];

    return Object.keys(rank).map((fileId) => {
      return (
        <ChessBoardSquare
          file={fileId}
          key={fileId}
          rank={rankId}
          piece={rank[fileId]}
          store={store}
        />
      );
    });
  }

  renderRanks() {
    const board = this.getBoard();

    return Object.keys(board).reverse().map((rankId) => {
      return (
        <div className="board-rank" key={rankId}>
          {this.renderFiles(rankId)}
        </div>
      );
    });
  }

  render() {
    return <div className="board">{this.renderRanks()}</div>;
  }
}

function mapStateToProps(state) {
  return { selectedSquare: state.selectedSquare }
}

export default connect(mapStateToProps)(ChessBoard);
