import React from "react";
import classNames from "classnames";

class ChessBoardSquare extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    if (this.props.square == undefined) {
      var squareClass = classNames(
        "board-square",
      )
    }
    else {
      var squareClass = classNames(
        "board-square",
        this.props.square.type,
        this.props.square.colour,
      )
    }

    return <div className={squareClass} />
  }
}

export default ChessBoardSquare;
