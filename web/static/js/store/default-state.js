const defaultState = {
  selectedSquare: null,

  board: {
    8: {
      a: { type: "rook",   colour: "black" },
      b: { type: "knight", colour: "black" },
      c: { type: "bishop", colour: "black" },
      d: { type: "queen",  colour: "black" },
      e: { type: "king",   colour: "black" },
      f: { type: "bishop", colour: "black" },
      g: { type: "knight", colour: "black" },
      h: { type: "rook",   colour: "black" }
    },
    7: {
      a: { type: "pawn", colour: "black" },
      b: { type: "pawn", colour: "black" },
      c: { type: "pawn", colour: "black" },
      d: { type: "pawn", colour: "black" },
      e: { type: "pawn", colour: "black" },
      f: { type: "pawn", colour: "black" },
      g: { type: "pawn", colour: "black" },
      h: { type: "pawn", colour: "black" }
    },
    6: { a: null, b: null, c: null, d: null, e: null, f: null, g: null, h: null },
    5: { a: null, b: null, c: null, d: null, e: null, f: null, g: null, h: null },
    4: { a: null, b: null, c: null, d: null, e: null, f: null, g: null, h: null },
    3: { a: null, b: null, c: null, d: null, e: null, f: null, g: null, h: null },
    2: {
      a: { type: "pawn", colour: "white" },
      b: { type: "pawn", colour: "white" },
      c: { type: "pawn", colour: "white" },
      d: { type: "pawn", colour: "white" },
      e: { type: "pawn", colour: "white" },
      f: { type: "pawn", colour: "white" },
      g: { type: "pawn", colour: "white" },
      h: { type: "pawn", colour: "white" }
    },
    1: {
      a: { type: "rook",   colour: "white" },
      b: { type: "knight", colour: "white" },
      c: { type: "bishop", colour: "white" },
      d: { type: "queen",  colour: "white" },
      e: { type: "king",   colour: "white" },
      f: { type: "bishop", colour: "white" },
      g: { type: "knight", colour: "white" },
      h: { type: "rook",   colour: "white" }
    }
  }
};

export default defaultState;
