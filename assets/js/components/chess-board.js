import React from "react";
import _ from "lodash";
import { connect } from "react-redux";
import classNames from "classnames";

import ChessBoardSquare from "./chess-board-square";
import RankLabels from "./rank-labels";
import FileLabels from "./file-labels";
import GameState from "./game-state";

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

  get boardClass() {
    const turn = this.getTurn();
    const player = this.getPlayer();

    return classNames("board", turn + "-to-move", "player-is-" + player);
  }

  render() {
    const { store } = this.props;

    return (
      <div className={this.boardClass}>
        <RankLabels />
        <FileLabels />

        <div className="board-body">
          {this.renderSquares()}
        </div>

        <GameState store={store} />
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
