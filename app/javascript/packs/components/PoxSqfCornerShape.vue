<template>
  <div>
  
  <h3>{{ options.options }}</h3>
  
  <label>
  SIZE: {{ options.size }}
  <input type="hidden" v-model='options.size' v-on:change='drawSelectedBoxes()'/>
  </label>
  <button v-on:click='setCornerSize(1)'>+</button>
  <button v-on:click='setCornerSize(-1)'>-</button>

  => the item will need {{ default_params.selected_boxes.length }} boxes.

  <label>
  There are {{ default_params.sqf.units }} units in one box.
  <br />
  how many UNIT cost ONE item per box?
  </label>
  <br />
  {{ options.cost_in_unit }}  units?
  <button v-on:click="updateUnitCost(1)">More</button>
  <button v-on:click="updateUnitCost(-1)">Less</button>
  <br />  
  <button 
    class='btn btn-primary'
    v-on:click='submitSpacing'
    v-bind:class="{ disabled: isFormValid() }"
    >
    submit
  </button>

  </div>
  </div>



</template>

<script>

export default {
  props: {
    item: {
      type: Object
    },
    options: {
      type: Object
    },
    default_params: {
      type: Object
    }, 
  },
  data: function() {
    return {
      // size: 1,
      // item_cost_in_unit: 1,
      // max_items: 1,
      // min_items: 1,
      // selected_boxes: [
      //   {col: 2, row: 2}
      // ],
      // sqf: {
      //   width: 30,
      //   units: 16
      // }
    }
  },
  created: function() {
    this.drawSelectedBoxes()
  },
  methods: {
    drawSelectedBoxes: function() {
      let selected_boxes = []
      let size = parseInt(this.options.size)

      let corner_box = {
        col: 1,
        row: 1
      }

      for (let col = corner_box.col; col <= (corner_box.col + size); col++) {
        if (!selected_boxes.find(box => box.col === col && box.row === corner_box.row)) {
          selected_boxes.push({
            col: col,
            row: corner_box.row
          })
        }
      }

      for (let row = corner_box.row; row <= (corner_box.row + size); row++) {
        if (!selected_boxes.find(box => box.col === corner_box.col && box.row === row)) {
          selected_boxes.push({
            col: corner_box.col,
            row: row          
          })
        }
      }

      this.$emit('set-plot-size', 2 + size)
      this.$emit('set-selected-boxes', selected_boxes)

    },
    setCornerSize: function(newSize) {
      this.options.size += newSize
      this.drawSelectedBoxes()
    },
    updateUnitCost: function(unit) {
      this.$emit('set-sqf-cost-item', unit)
    },
    submitSpacing: function() {
      this.$emit('submit-spacing', {spacing_id: this.options.spacing_id, options: this.name_options})
    },
    isFormValid: function() {
      if (this.options.cost_in_unit === 0)
        return true
      else
        return false
    },
  },
  computed: {
    name_options: function() {
      return 'corner-' + this.options.size + '-'
        + 'cost-' + this.options.cost_in_unit + '-'
        + 'max-' + this.max_items + '-'
        + 'min-' + this.min_items
    },
    max_items: function() {
      return (1 / this.default_params.selected_boxes.length).toFixed(2)
    },
    min_items: function() {
      return (1 / this.default_params.selected_boxes.length).toFixed(2)
    },    

  }
}

</script>

<style scoped>
.plot {
  border: 1px solid black;
}

.box {
  width: 60px;
  height: 60px;
  border: 1px black solid;
  display:inline-block;
}

.selected {
  background: red;
}
</style>