<template>
  <div class="board">
    <div v-for="row in board" class="board-row">
      <chess-piece v-for="piece in row" :piece="piece"></chess-piece>
    </div>
  </div>
</template>

<script>
import ChessPiece from "./chess-piece";

export default {
  components: { ChessPiece },

  computed: {
    board() {
      return this.$store.state.board;
    }
  },
};
</script>
