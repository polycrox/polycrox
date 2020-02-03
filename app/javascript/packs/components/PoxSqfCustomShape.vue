<template>
  <div>
  <div class="plot">
  <label>
  shape creator 
  </label>
  <button v-on:click="extendPlot(1)">extend plot size</button>
  
  <br />
  <label>
  how many boxes do need the item to grow? {{ selected_boxes.length }}
  </label>
  <br />

  <label>
  There are 16 units in one box.
  how many UNIT cost ONE item per box?
  </label>
  {{ item_cost_in_unit }} units?
  <button v-on:click="updateUnitCost(1)">More</button>
  <button v-on:click="updateUnitCost(-1)">Less</button>
  <br />
  <div v-if="selected_boxes.length == 1">
    we can put maximum <input type="integer" v-model='max_items' v-on:change="checkMaxItems()"/> 
    item per box
    <br />
    we can put minimum <input type="integer" v-model='min_items'/> 
    item per box
  </div>
  <div v-else>
    the item will cover {{ selected_boxes.length }} boxes.
    
  </div>
  
  

  <br />
  0 ... {{ rows * sqf.width }} cm
  <div v-for="col in cols" class="pox-row">
    <div 
      v-for="row in rows" 
      class="box" 
      v-bind:class="{ selected: isSelected(col, row) }"
      v-on:click="toggleBoxSelection(col, row)"
      >
      {{ col }}, {{ row }}
      <br />
      <span v-if="isSelected(col, row)">
       {{ item_cost_in_unit }}
      </span>
    </div>
    
  </div>
  ... {{ cols * sqf.width }} cm

  </div>

  # number of boxes to grow: min_box
      => 1; let's do first fidji in one box
    # shape; => 
      => default square(size: 1)
      *
      => square(size: 2)
      **
      **
  </div>



</template>

<script>

export default {
  props: [],
  data: function() {
    return {
      size: 1,
      item_cost_in_unit: 1,
      max_items: 1,
      min_items: 1,
      selected_boxes: [
        {col: 2, row: 2}
      ],
      sqf: {
        width: 30,
        units: 16
      }
    }
  },
  mounted: function() {
    this.max_items = this.max_item_units
  },
  methods: {
    isSelected: function(col, row) {
      return this.selected_boxes.find(box => box.col === col && box.row === row)
    },
    resetBoxes: function() {

    },
    extendPlot: function(inc) {
      this.size += inc
    },
    toggleBoxSelection: function(col, row) {
      let boxIndex = this.selected_boxes.indexOf(this.isSelected(col, row))
      if (boxIndex >= 0) {
        this.selected_boxes.splice(boxIndex, 1)
      } else {
        if (this.checkBoxPosition(col, row)) {
          console.log('true')
          this.selected_boxes.push({
            col: col,
            row: row
          })        
        } else {
          console.log('false')
        }
      }

    },
    checkBoxPosition: function(col, row) {
      if (this.lookBoxUp(col, row) || 
        this.lookBoxDown(col, row) ||
        this.lookBoxLeft(col, row) || 
        this.lookBoxRight(col, row)) {
          return true 
        }
      return false
    },
    lookBoxUp: function(col, row) {
      let look = this.selected_boxes.find(box => box.col === (col - 1) && box.row === row)
      console.log('lookBoxUp', col, row, look)
      return look
      
    },
    lookBoxDown: function(col, row) {
      let look =  this.selected_boxes.find(box => box.col === (col + 1) && box.row === row)
      console.log('lookBoxDown', col, row, look)
      return look

    },
    lookBoxLeft: function(col, row) {
      
      let look = this.selected_boxes.find(box => box.col === col && box.row === (row - 1))
      console.log('lookBoxLeft', col, row, look)
      return look

    },
    lookBoxRight: function(col, row) {
      let look = this.selected_boxes.find(box => box.col === col && box.row === (row + 1))
      console.log('lookBoxRight', col, row, look)
      return look
    },
    updateUnitCost: function(unit) {
      if (this.item_cost_in_unit >= 0)
        this.item_cost_in_unit += unit
      this.max_items = this.max_item_units
    },
    checkMaxItems: function() {
      if (this.max_items > this.max_item_units)
        this.max_items = this.max_item_units
    }
  },
  computed: {
    max_item_units: {
      get: function() {
        if (this.selected_boxes.length > 1)
          return 1 / this.selected_boxes.length
        else
          return this.sqf.units / this.item_cost_in_unit
      },
      set: function(newValue) {
        this.max_items = newValue
      }
    },
    rows: {
      get: function() {
        return parseInt(this.size) + 2
      },
      set: function(newValue) {
        this.size = parseInt(newValue)
      }
    },
    cols: function() {
      return parseInt(this.size) + 2
    }
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