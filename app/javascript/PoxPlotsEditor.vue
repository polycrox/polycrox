<template>

  
    <div class="row">
      <div class="col-sm-2">
      This plots contains:
      <ul>
        <li>nothing</li>
      </ul>
      </div>

      <div class='col-sm-6'>
        <div v-for="(x, x_index) in plot.rows" class="row no-gutters">
          <div v-for="(y, y_index) in plot.cols" class="col card">
            {{ x }} / {{ y }}
            {{ currentBox(x, y).id }}
          </div>
        </div>      </div>

      <div class="col-sm">
        <pox-crops-editor 
          :plot_id='plot.id'>
        </pox-crops-editor>
      </div>

    </div>

</template>

<script>


export default {
  props: ['garden', 'plot', 'boxes'],
  data: function () {
    return {
    }
  },
  created: function() {

  },
  computed: {
  },
  methods: {
    currentBox: function(x, y) {
      return this.boxes.find(box => box.pos_x === x && box.pos_y === y);
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
