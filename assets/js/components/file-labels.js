import React from "react";
import _ from "lodash";

class FileLabels extends React.Component {
  get fileLabels() {
    return ["a", "b", "c", "d", "e", "f", "g", "h"];
  }

  renderFileLabels() {
    return _.map(this.fileLabels, (fileLabel) => {
      return (
        <div key={fileLabel} className="board-label">{fileLabel}</div>
      );
    });
  }

  render() {
    return (
      <div className="board-file-labels">
        {this.renderFileLabels()}
      </div>
    );
  }
}

export default FileLabels;
