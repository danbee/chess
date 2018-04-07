import React from "react";
import classNames from "classnames";

class GameState extends React.Component {
  get gameStates() {
    return {
      "checkmate": "Checkmate!",
      "stalemate": "Stalemate",
      "check": "Check",
    };
  }

  get gameState() {
    const { store } = this.props;
    return store.getState().state;
  }

  get friendlyGameState() {
    return this.gameStates[this.gameState];
  }

  get gameStateClass() {
    const state = this.gameState;

    return classNames("board-game-state", state);
  }

  render() {
    return (
      <div className={this.gameStateClass}>
        {this.friendlyGameState}
      </div>
    );
  }
}

export default GameState;
