import React from "react";
import classNames from "classnames";

class ChessBoardSquare extends React.Component {
  constructor(props) {
    super(props);

    this.selectSquare = this.selectSquare.bind(this);
  }

  selectSquare() {
    console.log(`Clicked: ${this.props.rank}, ${this.props.file}`);
  };

  render() {
    if (this.props.square == undefined) {
      var squareClass = "board-square";
    }
    else {
      var squareClass = classNames(
        "board-square",
        this.props.square.type,
        this.props.square.colour,
      )
    }

    return <div className={squareClass} onClick={this.selectSquare} />
  }
}

export default ChessBoardSquare;
