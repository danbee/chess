import React from "react";
import _ from "lodash";
import $ from "jquery";
import classNames from "classnames";

import { selectPiece, setBoard } from "../store/actions";

class ChessBoardSquare extends React.Component {
  constructor(props) {
    super(props);
  }

  squareCoords() {
    return [this.props.file, this.props.rank];
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
      return _.isEqual(this.squareCoords(), store.getState().selectedSquare);
    }
  }

  squareId() {
    return `f${this.props.file}-r${this.props.rank}`;
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
    return <td
      id={this.squareId()}
      className={this.squareClass()}
      onClick={this.selectSquare.bind(this)}
    />
  }
}

export default ChessBoardSquare;
