"use strict";

import "phoenix_html";

import React from "react";
import ReactDOM from "react-dom";
import _ from "lodash";

import API from "../services/api";

class OpponentFinder extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      queryString: "",
      foundOpponents: [],
      selectedOpponent: "",
      selectedOpponentId: "",
      focusedOpponent: null,
    };

    this.opponentResults = [];

    this.debouncedSearch = _.debounce(this.search.bind(this), 250);
  }

  componentDidUpdate() {
    if (this.state.focusedOpponent !== null) {
      this.opponentResults[this.state.focusedOpponent].focus();
    }
  }

  search() {
    if (this.state.queryString != "") {
      API.findOpponent(this.state.queryString)
        .then((response) => {
          this.setState({ foundOpponents: response.data.opponents });
        });
    } else {
      this.setState({ foundOpponents: [] });
    }
  }

  handleChange(event) {
    this.setState({ queryString: event.target.value });
    this.debouncedSearch();
  }

  handleFocus(event) {
    if (this.state.selectedOpponent) {
      this.setState({ queryString: "" });
    }
  }

  handleBlur(event) {
    if (this.state.selectedOpponent) {
      this.setState({ queryString: this.state.selectedOpponent.name });
    }
  }

  handleKeyPress(event) {
    if (this.isKeyingDown(event)) { this.focusNextOpponent(); }

    if (this.isKeyingUp(event)) { this.focusPreviousOpponent(); }
  }

  isKeyingDown(event) {
    return event.key === "ArrowDown" || (event.key === "Tab" && !event.shiftKey);
  }

  isKeyingUp(event) {
    return event.key === "ArrowUp" || (event.key === "Tab" && event.shiftKey);
  }

  focusNextOpponent() {
    if (this.state.focusedOpponent === null) {
      this.setState({ focusedOpponent: 0 });
    } else if (this.state.focusedOpponent < this.state.foundOpponents.length - 1) {
      this.setState({ focusedOpponent: this.state.focusedOpponent + 1 });
    }
  }

  focusPreviousOpponent() {
    if (this.state.focusedOpponent > 0) {
      this.setState({ focusedOpponent: this.state.focusedOpponent - 1 });
    } else {
      this.setState({ focusedOpponent: null });
      this.queryStringInput.select();
    }
  }

  selectOpponent(event) {
    event.preventDefault();

    const selectedOpponentId = event.target.attributes["data-id"].value;
    const selectedOpponent = _.find(this.state.foundOpponents, (opponent) => {
      return opponent.id == selectedOpponentId;
    });

    this.setState({
      selectedOpponentId,
      selectedOpponent,
      foundOpponents: [],
      queryString: selectedOpponent.name,
      focusedOpponent: null,
    });
  }

  renderOpponents() {
    return _.map(this.state.foundOpponents, (opponent, index) => {
      return (
        <li key={opponent.id}>
          <a
            className="opponent-finder__result-item"
            ref={(link) => { this.opponentResults[index] = link; }}
            data-id={opponent.id}
            href="#"
            onClick={this.selectOpponent.bind(this)}
          >{opponent.name}</a>
        </li>
      );
    });
  }

  renderOpponentsResult() {
    if (this.state.foundOpponents.length) {
      return (
        <ul className="opponent-finder__result">
          {this.renderOpponents()}
        </ul>
      );
    }
  }

  render() {
    const { store, gameId } = this.props;

    return (
      <div
        className="form-field opponent-finder"
        onKeyUp={this.handleKeyPress.bind(this)}
      >
        <label htmlFor="query-string">Find opponent</label>
        <input
          id="query-string"
          ref={(input) => { this.queryStringInput = input; }}
          name="q"
          value={this.state.queryString}
          onChange={this.handleChange.bind(this)}
          onFocus={this.handleFocus.bind(this)}
          onBlur={this.handleBlur.bind(this)}
          type="text"
          autoComplete="off"
        />
        <input
          name="game[opponent_id]"
          type="hidden"
          value={this.state.selectedOpponentId}
        />

        {this.renderOpponentsResult()}
      </div>
    );
  }
}

export default OpponentFinder;
