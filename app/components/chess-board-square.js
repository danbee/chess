import React from "react";
import classNames from "classnames";

import { movePiece, selectPiece } from "store/actions";

class ChessBoardSquare extends React.Component {
  constructor(props) {
    super(props);

    this.selectSquare = this.selectSquare.bind(this);
  }

  squareCoords() {
    return { rank: this.props.rank, file: this.props.file };
  }

  selectSquare() {
    var { store } = this.props;
    console.log(`Clicked: ${this.props.file}${this.props.rank}`);

    if (this.props.piece != undefined) {
      store.dispatch(selectPiece(this.squareCoords()));
    }
    else {
      console.log("About to move!");
      store.dispatch(movePiece(store.getState().selectedSquare, this.squareCoords()));
      console.log("Moved!");
    }

    console.log(store.getState().selectedSquare);
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

  render() {
    if (this.props.piece == undefined) {
      var squareClass = "board-square";
    }
    else {
      var squareClass = classNames(
        "board-square",
        this.props.piece.type,
        this.props.piece.colour,
        { "selected": this.isSelectedSquare() }
      )
    }

    return <div className={squareClass} onClick={this.selectSquare} />
  }
}

export default ChessBoardSquare;
