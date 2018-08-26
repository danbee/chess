import React from "react";
import { connect } from "react-redux";

const GameInfo = (props) => {
  return (
    <div className="game-info">
      <p>
        Playing {props.opponent} - <span className={props.opponentStatus}>
          {props.opponentStatus}
        </span>
      </p>
    </div>
  );
};

const mapStateToProps = (state) => {
  return {
    opponent: state.opponent,
    opponentStatus: state.opponentStatus,
  };
};

export default connect(mapStateToProps)(GameInfo);
