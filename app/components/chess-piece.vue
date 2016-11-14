<template>
  <div class="board-square" :class="classes(piece)">
  </div>
</template>

<script>
export default {
  methods: {
    classes: (piece) => {
      if (piece != null) {
        return [piece.type, piece.colour];
      }
    },
  },

  props: ["piece"]
};
</script>
