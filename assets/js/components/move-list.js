import React from "react";
import _ from "lodash";
import { connect } from "react-redux";
import classNames from "classnames";

const pieceToNotation = (piece) => {
  const pieces = {
    pawn: "",
    knight: "N",
    bishop: "B",
    rook: "R",
    queen: "Q",
    king: "K",
  };

  return pieces[piece.type];
};

const moveClass = (move) => {
  return classNames("move-list__move", "move-list__move--" + move.piece.colour);
};

const renderMove = (move) => {
  if (move != undefined) {
    return (
      <td className={moveClass(move)}>
        {pieceToNotation(move.piece)}
        {move.piece_captured ? "x" : ""}
        {move.to}
      </td>
    );
  }
};

const renderMoves = (moves) => {
  let lineNumber = 1;

  return _.map(moves, (move) => {
    return (
      <tr key={move[0].id}>
        <th scope="row" className="move-list__line-number">{lineNumber++}.</th>
        {renderMove(move[0])}
        {renderMove(move[1])}
      </tr>
    );
  });
};

const MoveList = (props) => {
  return (
    <div className="move-list">
      <table className="table table--condensed">
        <thead>
          <tr>
            <th className="move-list__line-number">
              <span className="visually-hidden">Move no.</span>
            </th>

            <th className="move-list__header--white">White</th>
            <th className="move-list__header--black">Black</th>
          </tr>
        </thead>

        <tbody>
          {renderMoves(props.moves)}
        </tbody>
      </table>
    </div>
  );
};

const mapStateToProps = (state) => {
  return {
    moves: state.moves,
  };
};

export default connect(mapStateToProps)(MoveList);
