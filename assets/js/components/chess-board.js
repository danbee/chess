import React from "react";
import _ from "lodash";
import { connect } from "react-redux";
import classNames from "classnames";

import API from "../services/api";
import Channel from "../services/channel";

import { setPlayer, setGame, setGameId } from "../store/actions";

import ChessBoardSquare from "./chess-board-square";

class ChessBoard extends React.Component {
  componentWillMount() {
    const { gameId, store } = this.props;

    store.dispatch(setGameId(gameId));

    API.getGame(gameId)
      .then(response => {
        store.dispatch(setPlayer(response.data.player));
        store.dispatch(setGame(response.data));
      });

    this.channel = Channel.gameChannel(gameId);

    this.channel.on("game_update", data => {
      store.dispatch(setGame(data));
    });
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

  renderFiles(rankId) {
    const { store } = this.props;
    const rank = this.getBoard()[rankId];

    return _.map(this.files(rank), fileId => {
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
        <div className="board-header">
          <div className="board-border-top" />
        </div>
        <div className="board-body">
          <div className="board-border-left" />
          <div className="board-ranks">{this.renderRanks()}</div>
          <div className="board-border-right" />
        </div>
        <div className="board-footer">
          <div className="board-border-bottom" />
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
