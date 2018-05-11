import React from "react";
import { connect } from "react-redux";
import _ from "lodash";

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

const renderMove = (move) => {
  if (move != undefined) {
    return (
      <td className="move">{pieceToNotation(move.piece)}{move.to}</td>
    )
  }
}

const renderMoves = (moves) => {
  return _.map(moves, (move) => {
    return (
      <tr key={move[0].id}>
        {renderMove(move[0])}
        {renderMove(move[1])}
      </tr>
    );
  });
};

const MoveList = (props) => {
  return (
    <table className="move-list">
      <thead>
        <tr>
          <th>White</th>
          <th>Black</th>
        </tr>
      </thead>
      <tbody>
        {renderMoves(props.moves)}
      </tbody>
    </table>
  );
};

const mapStateToProps = (state) => {
  return {
    moves: state.moves,
  };
};

export default connect(mapStateToProps)(MoveList);
