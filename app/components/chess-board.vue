<template>
  <div class="board">
    <div v-for="row in board" class="board-row">
      <div v-for="square in row" class="board-square">
      </div>
    </div>
  </div>
</template>

<script>
export default {
  computed: {
    board() {
      return this.$store.state.board;
    }
  },
};
</script>
