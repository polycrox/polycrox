<template>
  <div>
  <div class="plot">
  <h1>rectangle spacing</h1>

  <label>
  SIZE:
  </label>
  <input v-model='params.width' v-on:change='drawSelectedBoxes()'/> x <input v-model='params.height' v-on:change='drawSelectedBoxes()' /> 
  => the item will need <b>{{ default_params.selected_boxes.length }}</b> boxes.
  <br />

  <br />
  <label>
  There are 16 units in one box.
  <br />
  how many UNIT cost ONE item per box?
  </label>
  {{ default_params.sqf_item.cost_in_unit }}  units?
  <button v-on:click="updateUnitCost(1)">More</button>
  <button v-on:click="updateUnitCost(-1)">Less</button>
  <br />  

  </div>
  </div>



</template>

<script>

export default {
  props: {
    item: {
      type: Object
    },
    params: {
      type: Object
    },
    default_params: {
      type: Object
    },
    default_sqf: {
      type: Object
    }
  },
  data: function() {
    return {
    }
  },
  mounted: function() {
    this.drawSelectedBoxes()

  },
  methods: {
    drawSelectedBoxes: function() {
      let width = this.params.width
      let height = this.params.height
      console.log('width', width, 'height', height)
      let selected_boxes = []
      let init_box = {
        col: 2,
        row: 2
      }

      // something is wrong here
      // fuck that, i'll do it later, sorry future me


      for (let i = 0; i < height; i++) {
        let next_col = init_box.col + i

        if (!selected_boxes.find(box => box.col === next_col && box.row === init_box.row)) {
          selected_boxes.push({
            col: next_col,
            row: init_box.row
          })
        }
      }      

     for (let i = 0; i < width; i++) {
        let next_row = init_box.row + i

        if (!selected_boxes.find(box => box.col === init_box.col && box.row === next_row)) {
          selected_boxes.push({
            col: init_box.col,
            row: next_row
          })
        }
      }
      
      // for (let row = init_box.row; row < (init_box.row + width); row++) {
      //   if (!selected_boxes.find(box => box.col === init_box.col && box.row === row)) {
      //     selected_boxes.push({
      //       col: init_box.col,
      //       row: row
      //     })
      //   }
      // }      
      // for (let row = init_box.row; row < (init_box.row + width); row++) {
      //   if (!selected_boxes.find(box => box.row === row && box.col === init_box.col)) {
      //     selected_boxes.push({
      //       row: row,
      //       col: init_box.col
      //     })
      //   }
      // }

      // for (let col = init_box.col; col < (init_box.col + height); col++) {
      //   if (!selected_boxes.find(box => box.col === col && box.row === init_box.row)) {
      //     selected_boxes.push({
      //       col: col,
      //       row: init_box.row
      //     })
      //   }
      // }          
      this.$emit('set-plot-size', 2 + (Math.max(width, height)))


      this.$emit('set-selected-boxes', selected_boxes)
      console.log(selected_boxes)
    },
    updateUnitCost: function(unit) {
      this.$emit('set-sqf-cost-item', unit)
    },
    submitSpacing: function() {
      this.$emit('submit-spacing', this.name_options)
    }     
  },
  computed: {
    name_options: function() {
      return 'line-' + this.params.size + '-'
        + 'cost-' + this.default_params.sqf_item.cost_in_unit + '-'
        + 'max-' + this.max_items + '-'
        + 'min-' + this.min_items
    },
    max_items: function() {
      return 1 / this.default_params.selected_boxes.length
    },
    min_items: function() {
      return 1 / this.default_params.selected_boxes.length
    },  
  }
}

</script>

<style scoped>
.plot {
  border: 1px solid black;
}

.box {
  width: 90px;
  height: 90px;
  border: 1px black solid;
  display:inline-block;
}

.selected {
  background: red;
}
</style>