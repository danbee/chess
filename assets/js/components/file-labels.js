import React from "react";
import _ from "lodash";
import classNames from "classnames";

class FileLabels extends React.Component {
  constructor(props) {
    super(props);
  }

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
