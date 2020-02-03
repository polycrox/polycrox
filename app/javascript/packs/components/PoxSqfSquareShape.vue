<template>
  <div>
  
  <h3>{{ options.options }}</h3>
  
  <label>
  SIZE: {{ options.size }}x{{ options.size }}
  </label>
  <input type="hidden" v-model='options.size' v-on:change='drawSelectedBoxes()'/>

  <button v-on:click='setSquareSize(1)'>+</button>
  <button v-on:click='setSquareSize(-1)'>-</button>
  => the item will need <b>{{ default_params.selected_boxes.length }}</b> boxes.
  <br />
  <input type="checkbox" v-model='options.edge' v-on:change='drawSelectedBoxes()'/>
  <label>edge? (one face must be on the edge, any face)</label>
  <br />
  <input type="checkbox" v-model='options.corner' v-on:change='drawSelectedBoxes()'/>
  <label>corner? (one corner must be in a corner, any corner)</label>
  <br />
  


  <br />
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
  <div v-if="default_params.selected_boxes.length == 1">
    we can put maximum {{ options.max_items }}
    <input type="hidden" v-model='options.max_items' v-on:change="checkMaxItems()"/> 

    item per box - <button v-on:click="updateMaxItem(-1)">Less</button> 
    <br />
    we can put minimum {{ options.min_items }}
    <input type="hidden" v-model='options.min_items'/> 
    item per box <button v-on:click="updateMinItem(-1)">Less</button> 
  </div>
  <div v-else>
    the item will cover {{ default_params.selected_boxes.length }} boxes.

    {{ options.max_items }} /  {{ options.min_items }}
    
  </div>

  <button 
    class='btn btn-primary'
    v-on:click='submitSpacing'
    v-bind:class="{ disabled: isFormValid() }"
    >
    {{ options.spacing_id ? 'edit' : 'create' }}
    
  </button>
  
  



  
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
    default_sqf: {
      type: Object
    }
  },
  data: function() {
    return {
    }
  },
  watch: {
    options: function(n, o) {
      this.drawSelectedBoxes()
    }
  },
  created: function() {
    this.drawSelectedBoxes()
  },
  methods: {
    drawSelectedBoxes: function() {
      let selected_boxes = []
      let size = parseInt(this.options.size)      
      
      let start = (this.options.edge ? 1 : 2)
      let my_col, my_row
      if (this.options.edge) {
        my_col = 1
        my_row = 2
      } else if (this.options.corner) {
        my_col = 1
        my_row = 1
      } else {
        my_col = 2
        my_row = 2
      }

      for (let col = my_col; col < (my_col + size); col++) {
        for (let row = my_row; row < (my_row + size); row++) {
          selected_boxes.push({
            col: col,
            row: row
          })
        }
      }
      this.$emit('set-plot-size', 2 + size)
      this.$emit('set-selected-boxes', selected_boxes)
    },
    isFormValid: function() {
      if (this.options.cost_in_unit === 0)
        return true
      else
        return false
    },
    updateMaxItem: function(unit) {
      this.$emit('set-sqf-max-item', unit)
    },
    updateMinItem: function(unit) {
      this.$emit('set-sqf-min-item', unit)
    },
    updateUnitCost: function(unit) {
      this.$emit('set-sqf-cost-item', unit)
    },
    submitSpacing: function() {
      this.$emit('submit-spacing', {spacing_id: this.options.spacing_id, options: this.name_options})
    },
    setSquareSize: function(newSize) {
      this.options.size += newSize
      this.drawSelectedBoxes()
    }
  },
  computed: {
    name_options: function() {
      return (this.options.edge ? 'edge-' : '') 
        + (this.options.corner ? 'corner-' : '')
        + 'square-' + this.options.size + '-'
        + 'cost-' + this.options.cost_in_unit + '-'
        + 'max-' + this.max_items + '-'
        + 'min-' + this.min_items
    },
    max_items: function() {
      if (this.default_params.selected_boxes.length ===  1)
        return this.options.max_items
      else
        return Math.round(1 / this.default_params.selected_boxes.length)
    },
    min_items: function() {
      if (this.default_params.selected_boxes.length === 1)
        return this.options.min_items
      else
        return Math.round(1 / this.default_params.selected_boxes.length)
    },    
    number_of_boxes: function() {
      return this.options.size * this.options.size
    }
  }
}

</script>

<style scoped>

</style>