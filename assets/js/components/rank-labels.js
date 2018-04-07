import React from "react";
import _ from "lodash";

class RankLabels extends React.Component {
  get rankLabels() {
    return [1, 2, 3, 4, 5, 6, 7, 8];
  }

  renderRankLabels() {
    return _.map(this.rankLabels, (rankLabel) => {
      return (
        <div key={rankLabel} className="board-label">{rankLabel}</div>
      );
    });
  }

  render() {
    return (
      <div className="board-rank-labels">
        {this.renderRankLabels()}
      </div>
    );
  }
}

export default RankLabels;
