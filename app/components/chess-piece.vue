<template>
  <div class="board-square">
    <img v-if="piece != null" :src="pieceImage(piece)">
  </div>
</template>

<script>
export default {
  methods: {
    pieceImage: (piece) => {
      return "/images/"
        + piece.type
        + "_"
        + piece.colour
        + ".svg";
    }
  },

  props: ["piece"]
};
</script>
