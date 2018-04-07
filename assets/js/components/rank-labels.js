import React from "react";
import _ from "lodash";
import classNames from "classnames";

class RankLabels extends React.Component {
  constructor(props) {
    super(props);
  }

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
