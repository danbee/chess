import React from "react";
import _ from "lodash";
import $ from "jquery";
import { connect } from "react-redux";
import { setPlayer, setGame, setGameId } from "../store/actions";

import ChessBoardSquare from "./chess-board-square";

import socket from "../socket";

class ChessBoard extends React.Component {
  componentWillMount() {
    const { gameId, store } = this.props;

    store.dispatch(setGameId(gameId));

    $.ajax({ method: "GET", url: `/api/games/${gameId}` })
      .then((data) => {
        store.dispatch(setPlayer(data.player));
        store.dispatch(setGame(data));
      });

    this.channel = socket.channel("game:" + gameId, {});
    this.channel.join();

    this.channel.on("game_update", data => {
      store.dispatch(setGame(data));
    });
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

    return _.map(this.files(rank), (fileId) => {
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

    return _.map(this.ranks(), (rankId) => {
      return (
        <tr className="board-rank" key={rankId}>
          {this.renderFiles(rankId)}
        </tr>
      );
    });
  }

  files(rank) {
    const player = this.getPlayer();

    switch (player) {
      case 'white':
        return Object.keys(rank).sort();
      case 'black':
        return Object.keys(rank).sort().reverse();
    }
  }

  ranks() {
    const board = this.getBoard();
    const player = this.getPlayer();

    switch (player) {
      case 'white':
        return Object.keys(board).reverse();
      case 'black':
        return Object.keys(board);
    }
  }

  render() {
    return (
      <table className="board">
        <tbody>{this.renderRanks()}</tbody>
      </table>
    );
  }
}

function mapStateToProps(state) {
  return {
    board: state.board,
    selectedSquare: state.selectedSquare
  }
}

export default connect(mapStateToProps)(ChessBoard);
