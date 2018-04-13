import React from "react";
import classNames from "classnames";
import i18n from "gettext.js";

const i = i18n();

const GAME_STATES = {
  "checkmate": i.gettext("Checkmate!"),
  "stalemate": i.gettext("Stalemate"),
  "check": i.gettext("Check"),
};

const friendlyGameState = (state) => {
  return GAME_STATES[state];
};

const gameStateClass = (state) => {
  return classNames("board-game-state", state);
};

const GameState = (props) => {
  return (
    <div className={gameStateClass(props.gameState)}>
      {friendlyGameState(props.gameState)}
    </div>
  );
};

export default GameState;
