import React from "react";
import _ from "lodash";
import { connect } from "react-redux";
import classNames from "classnames";

import ChessBoardSquare from "./chess-board-square";

class ChessBoard extends React.Component {
  componentWillMount() {
    const { gameId, store } = this.props;
  }

  getTurn() {
    const { store } = this.props;
    return store.getState().turn;
  }

  getBoard() {
    const { store } = this.props;
    return store.getState().board;
  }

  getPlayer() {
    const { store } = this.props;
    return store.getState().player;
  }

  renderSquares() {
    const board = this.getBoard();
    const { store, channel } = this.props;

    return _.map(this.ranks(), (rankId) => {
      const rank = this.getBoard()[rankId];

      return _.map(this.files(rank), (fileId) => {
        return (
          <ChessBoardSquare
            file={fileId}
            key={fileId}
            rank={rankId}
            piece={board[rankId][fileId]}
            store={store}
            channel={channel}
          />
        );
      });
    });
  }

  renderRanks() {
    const board = this.getBoard();

    return _.map(this.ranks(), rankId => {
      return (
        <div className="board-rank" key={rankId}>
          {this.renderFiles(rankId)}
        </div>
      );
    });
  }

  files(rank) {
    const player = this.getPlayer();

    switch (player) {
      case "white":
        return Object.keys(rank).sort();
      case "black":
        return Object.keys(rank)
          .sort()
          .reverse();
    }
  }

  ranks() {
    const board = this.getBoard();
    const player = this.getPlayer();

    switch (player) {
      case "white":
        return Object.keys(board).reverse();
      case "black":
        return Object.keys(board);
    }
  }

  get boardClass() {
    const turn = this.getTurn();
    const player = this.getPlayer();

    return classNames("board", turn + "-to-move", "player-is-" + player);
  }

  render() {
    return (
      <div className={this.boardClass}>
        <div className="board-body">
          {this.renderSquares()}
        </div>
      </div>
    );
  }
}

function mapStateToProps(state) {
  return {
    board: state.board,
    selectedSquare: state.selectedSquare,
  };
}

export default connect(mapStateToProps)(ChessBoard);
