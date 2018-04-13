import React from "react";
import _ from "lodash";

const FILE_LABELS = ["a", "b", "c", "d", "e", "f", "g", "h"];

const renderFileLabels = () => {
  return _.map(FILE_LABELS, (fileLabel) => {
    return (
      <div key={fileLabel} className="board-label">{fileLabel}</div>
    );
  });
};

const FileLabels = () => {
  return (
    <div className="board-file-labels">
      {renderFileLabels()}
    </div>
  );
};

export default FileLabels;
