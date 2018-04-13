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

  get turn() {
    const { store } = this.props;
    return store.getState().turn;
  }

  get board() {
    const { store } = this.props;
    return store.getState().board;
  }

  get player() {
    const { store } = this.props;
    return store.getState().player;
  }

  get gameState() {
    const { store } = this.props;
    return store.getState().state;
  }

  files(rank) {
    switch (this.player) {
      case "white":
        return Object.keys(rank).sort();
      case "black":
        return Object.keys(rank)
          .sort()
          .reverse();
    }
  }

  ranks() {
    const board = this.board;
    const player = this.player;

    switch (player) {
      case "white":
        return Object.keys(board).reverse();
      case "black":
        return Object.keys(board);
    }
  }

  renderSquares() {
    const { store, channel } = this.props;

    return _.map(this.ranks(), (rankId) => {
      const rank = this.board[rankId];

      return _.map(this.files(rank), (fileId) => {
        return (
          <ChessBoardSquare
            file={fileId}
            key={fileId}
            rank={rankId}
            piece={this.board[rankId][fileId]}
            store={store}
            channel={channel}
          />
        );
      });
    });
  }

  get boardClass() {
    const turn = this.turn;
    const player = this.player;

    return classNames("board", turn + "-to-move", "player-is-" + player);
  }

  render() {
    return (
      <div className={this.boardClass}>
        <RankLabels />
        <FileLabels />

        <div className="board-body">
          {this.renderSquares()}
        </div>

        <GameState gameState={this.gameState} />
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
