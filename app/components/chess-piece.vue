<template>
  <div class="board-square" :class="classes(piece)"
    v-on:click="selectSquare">
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
    selectSquare: () => {
      console.log("Clicked square");
    }
  },

  props: ["piece"]
};
</script>
