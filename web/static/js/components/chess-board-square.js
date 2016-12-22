import React from "react";
import $ from "jquery";
import classNames from "classnames";

import { selectPiece, setBoard } from "../store/actions";

class ChessBoardSquare extends React.Component {
  constructor(props) {
    super(props);

    this.selectSquare = this.selectSquare.bind(this);
  }

  squareCoords() {
    return { rank: this.props.rank, file: this.props.file };
  }

  selectSquare() {
    var { piece, store } = this.props;
    var { gameId, selectedSquare } = store.getState();

    if (selectedSquare != null) {
      $.ajax({
        method: "PATCH",
        url: "/api/games/" + gameId,
        data: { move: { from: selectedSquare, to: this.squareCoords() } }
      }).then((data) => store.dispatch(setBoard(data)));
    }
    else if (piece != undefined) {
      store.dispatch(selectPiece(this.squareCoords()));
    }
  };

  isSelectedSquare() {
    var { store } = this.props;

    if (store.getState().selectedSquare == null) {
      return false;
    }
    else {
      return this.squareCoords().rank == store.getState().selectedSquare.rank
        && this.squareCoords().file == store.getState().selectedSquare.file;
    }
  }

  squareId() {
    return this.props.file + this.props.rank;
  }

  squareClass() {
    if (this.props.piece == undefined) {
      return "board-square";
    }
    else {
      return classNames(
        "board-square",
        this.props.piece.type,
        this.props.piece.colour,
        { "selected": this.isSelectedSquare() }
      )
    }
  }

  render() {
    return <div
      id={this.squareId()}
      className={this.squareClass()}
      onClick={this.selectSquare}
    />
  }
}

export default ChessBoardSquare;
