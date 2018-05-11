import React from "react";
import { connect } from "react-redux";

const GameInfo = (props) => {
  return (
    <div className="game-info">
      <p>Playing {props.opponent}</p>
    </div>
  );
};

const mapStateToProps = (state) => {
  return {
    opponent: state.opponent,
  };
};

export default connect(mapStateToProps)(GameInfo);
