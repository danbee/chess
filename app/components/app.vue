<template>
  <div id="app">
    <chess-board></chess-board>
  </div>
</template>

<script>
import ChessBoard from './chess-board';
import ChessPiece from "./chess-piece";

export default {
  components: { ChessBoard, ChessPiece }
};
</script>
