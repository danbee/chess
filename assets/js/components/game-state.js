import React from "react";
import classNames from "classnames";

const GAME_STATES = {
  checkmate: "Checkmate!",
  stalemate: "Stalemate",
  check: "Check",
};

const friendlyGameState = (state) => {
  return GAME_STATES[state];
};

const gameStateClass = (state) => {
  return classNames("game-state", `game-state--${state}`);
};

const GameState = (props) => {
  return (
    <div className={gameStateClass(props.gameState)}>
      {friendlyGameState(props.gameState)}
    </div>
  );
};

export default GameState;
