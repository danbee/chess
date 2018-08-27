import React from "react";
import _ from "lodash";

const RANK_LABELS = [1, 2, 3, 4, 5, 6, 7, 8];

const renderRankLabels = () => {
  return _.map(RANK_LABELS, (rankLabel) => {
    return (
      <div key={rankLabel} className="board__label">{rankLabel}</div>
    );
  });
};

const RankLabels = () => {
  return (
    <div className="board__rank-labels">
      {renderRankLabels()}
    </div>
  );
};

export default RankLabels;
