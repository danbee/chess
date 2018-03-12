import React from "react";
import _ from "lodash";
import classNames from "classnames";

import API from "../services/api";

import { selectPiece } from "../store/actions";

class ChessBoardSquare extends React.Component {
  constructor(props) {
    super(props);
  }

  get squareCoords() {
    return [this.props.file, this.props.rank];
  }

  get squareId() {
    return `f${this.props.file}-r${this.props.rank}`;
  }

  get squareClass() {
    if (this.props.piece == undefined) {
      return classNames(
        "board-square",
        { "available": this.isAvailableSquare() }
      );
    } else {
      return classNames(
        "board-square",
        this.props.piece.type,
        this.props.piece.colour,
        { "selected": this.isSelectedSquare() },
        { "available": this.isAvailableSquare() }
      );
    }
  }

  selectSquare() {
    const { piece, store, channel } = this.props;
    const { gameId, selectedSquare, player } = store.getState();

    if (this.moveIsValid(selectedSquare)) {
      channel.sendMove({
        from: selectedSquare,
        to: this.squareCoords,
      });
    } else if (selectedSquare != null) {
      store.dispatch(selectPiece(null));
    } else if (this.playerCanSelectPiece(player, piece)) {
      store.dispatch(selectPiece(this.squareCoords));
      channel.getAvailableMoves(this.squareCoords);
    }
  }

  moveIsValid(selectedSquare) {
    return selectedSquare != null &&
      !this.isSelectedSquare() &&
      this.isAvailableSquare();
  }

  playerCanSelectPiece(player, piece) {
    const { store } = this.props;
    const { turn } = store.getState();

    return piece !== undefined &&
      piece.colour == player &&
      player == turn;
  }

  isSelectedSquare() {
    const { store } = this.props;

    if (store.getState().selectedSquare == null) {
      return false;
    } else {
      return _.isEqual(this.squareCoords, store.getState().selectedSquare);
    }
  }

  isAvailableSquare() {
    const { store } = this.props;
    const moves = store.getState().moves;

    return _.find(moves, (square) => {
      return square.join() == this.squareCoords.join();
    });
  }

  render() {
    return <div
      id={this.squareId}
      className={this.squareClass}
      onClick={this.selectSquare.bind(this)}
    />;
  }
}

export default ChessBoardSquare;
