import React from "react";
import { connect } from "react-redux";

const renderStatus = status => {
  if (status == "viewing") {
    return (
      <img
        className="game-info__opponent-status"
        src="/images/eye-open.svg"
        alt="viewing"
      />
    );
  } else {
    return (
      <img
        className="game-info__opponent-status"
        src="/images/eye-closed.svg"
        alt="offline"
      />
    );
  }
};

const GameInfo = props => {
  return (
    <div className="game-info">
      <p>
        Playing {props.opponent} {renderStatus(props.opponentStatus)}
      </p>
    </div>
  );
};

const mapStateToProps = state => {
  return {
    opponent: state.opponent,
    opponentStatus: state.opponentStatus,
  };
};

export default connect(mapStateToProps)(GameInfo);
