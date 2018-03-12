import React from "react";
import _ from "lodash";
import classNames from "classnames";

import API from "../services/api";

import { setGame, setMoves, selectPiece } from "../store/actions";

class ChessBoardSquare extends React.Component {
  constructor(props) {
    super(props);
  }

  get squareCoords() {
    return [this.props.file, this.props.rank];
  }

  selectSquare() {
    const { piece, store, channel } = this.props;
    const { gameId, selectedSquare, player } = store.getState();

    if (selectedSquare != null && this.moveIsValid()) {
      store.dispatch(setMoves([]));
      channel.sendMove({
        from: selectedSquare,
        to: this.squareCoords,
      });
    } else if (selectedSquare != null) {
      store.dispatch(setMoves([]));
      store.dispatch(selectPiece(null));
    } else if (this.playerCanSelectPiece(player, piece)) {
      channel.getAvailableMoves(this.squareCoords);
      store.dispatch(selectPiece(this.squareCoords));
    }
  }

  moveIsValid() {
    return !this.isSelectedSquare;
  }

  playerCanSelectPiece(player, piece) {
    const { store } = this.props;
    const { turn } = store.getState();

    return piece !== undefined &&
      piece.colour == player &&
      player == turn;
  }

  get isSelectedSquare() {
    const { store } = this.props;

    if (store.getState().selectedSquare == null) {
      return false;
    } else {
      return _.isEqual(this.squareCoords, store.getState().selectedSquare);
    }
  }

  get isAvailableSquare() {
    const { store } = this.props;
    const moves = store.getState().moves;

    return _.find(moves, function(square) {
      return square.join() == this.squareCoords.join();
    }.bind(this));
  }

  squareId() {
    return `f${this.props.file}-r${this.props.rank}`;
  }

  get squareClass() {
    if (this.props.piece == undefined) {
      return classNames(
        "board-square",
        { "available": this.isAvailableSquare }
      );
    } else {
      return classNames(
        "board-square",
        this.props.piece.type,
        this.props.piece.colour,
        { "selected": this.isSelectedSquare },
        { "available": this.isAvailableSquare }
      );
    }
  }

  render() {
    return <div
      id={this.squareId()}
      className={this.squareClass}
      onClick={this.selectSquare.bind(this)}
    />;
  }
}

export default ChessBoardSquare;
