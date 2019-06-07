import React from 'react';
import { connect } from "react-redux";

const Graveyard = props => {
  return (
    <div className="graveyard">
      <GraveStones colour="white" pieces={props.graveyard.white} />
      <GraveStones colour="black" pieces={props.graveyard.black} />
    </div>
  )
};

const mapStateToProps = state => {
  return {
    graveyard: state.graveyard
  };
};
  
export default connect(mapStateToProps)(Graveyard);

const GraveStones = ({ colour, pieces}) => {
  return (
    <ul className="graveyard__stones">
      {pieces.map(({colour, type}, index) => {
        return <GraveStone key={`${colour}${type}${index}`} colour={colour} type={type} />
      })}
    </ul>
  )
}

const GraveStone = ({ colour, type }) => {
  return <li class="graveyard__stone">
    <img src={`/images/${type}_${colour}.svg`} />
  </li>
}