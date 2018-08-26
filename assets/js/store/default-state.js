const defaultState = {
  selectedSquare: null,

  playerId: null,
  opponentId: null,

  player: null,
  opponent: null,
  turn: null,
  state: null,

  opponentStatus: "offline",

  availableMoves: [],

  moves: [],

  board: {
    8: { a: null, b: null, c: null, d: null, e: null, f: null, g: null, h: null },
    7: { a: null, b: null, c: null, d: null, e: null, f: null, g: null, h: null },
    6: { a: null, b: null, c: null, d: null, e: null, f: null, g: null, h: null },
    5: { a: null, b: null, c: null, d: null, e: null, f: null, g: null, h: null },
    4: { a: null, b: null, c: null, d: null, e: null, f: null, g: null, h: null },
    3: { a: null, b: null, c: null, d: null, e: null, f: null, g: null, h: null },
    2: { a: null, b: null, c: null, d: null, e: null, f: null, g: null, h: null },
    1: { a: null, b: null, c: null, d: null, e: null, f: null, g: null, h: null },
  },
};

export default defaultState;
