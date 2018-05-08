import React from "react";
import { connect } from "react-redux";
import _ from "lodash";

const renderMoves = (moves) => {
  return _.map(moves, (move) => {
    return (
      <li key={move}>{move}</li>
    );
  });
};

const MoveList = (props) => {
  return (
    <ol className="move-list">
      {renderMoves(props.moves)}
    </ol>
  );
};

function mapStateToProps(state) {
  return {
    moves: state.moves,
  };
}

export default connect(mapStateToProps)(MoveList);
