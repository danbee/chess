import Immutable from "immutable";
import { Map } from "immutable";

const movePiece = (board, from, to) => {
  const newBoard = Immutable.fromJS(board);
  const piece = board[from.rank][from.file];

  const boardChange = Map([
    [from.rank, Map([[from.file, null]])]
  ]).mergeDeep(Map([
    [to.rank, Map([[to.file, piece]])]
  ]));

  return newBoard.mergeDeep(boardChange).toJS();
}

export default movePiece;
