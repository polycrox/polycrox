<template>
  <div class="row">
    <div class="col-sm-12">
      Plot size: {{ default_params.plot_size }}x{{ default_params.plot_size }} <button v-on:click="extendPlot(default_params.plot_size + 1)">extend plot size</button>
      <br />
    </div>
        
        
    <div class="col-sm-6">
      spacings : 
      <ul>
        <li v-for='(spacing, index) in spacings'>{{ spacing.options }} - <a v-on:click='editSpacing(spacing)'>edit</a></li>
      </ul>
      <br />
      create a new spacing:
      <ul>
        <li>square(size: 1) <a v-on:click="newSpacing('square')">choose</a></li>
        <li>corner(size: 1) <a v-on:click="newSpacing('corner')">choose</a></li>
        <!-- <li>rectangle(size: 1) <a v-on:click="setSpacingComponent('line')">choose</a></li> -->
      </ul>

      <!-- <keep-alive> -->
        <component 
          v-on:set-selected-boxes="setSelectedBoxes($event)"
          v-on:set-plot-size='extendPlot($event)'
          v-on:set-sqf-max-item='setSqfMaxItem($event)'
          v-on:set-sqf-min-item='setSqfMinItem($event)'
          v-on:set-sqf-cost-item='setSqfCostItem($event)'
          v-on:submit-spacing='submitSpacing($event)'
          v-bind:is="currentSpacingComponent" 
          v-bind='{item: item, options: spacingParams, default_params: default_params}'
          >
        </component>
      <!-- </keep-alive> -->

    </div>
    <div class="col-sm-6">
      <div v-bind:class='classPlot'>
        <div class='scale scale-hor'>
          <span class="scale-init">0</span>
          <span class="scale-default">{{ default_params.sqf.width }}</span>
          <span class="scale-max">{{ default_params.plot_size * default_params.sqf.width }} cm</span>
        </div>
        <div v-for="col in default_params.plot_size" class="pox-row">
          <div 
            v-for="row in default_params.plot_size" 
            class="box" 
            v-bind:class="{ selected: isSelected(col, row) }"
            >
            {{ col }}, {{ row }}
            <br />
            <div class="units" v-if="isSelected(col, row)">
              <span v-for='unit in spacingParams.max_items'>
                |  
              </span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

</template>

<script>

export default {
  props: ['item'],
  data: function() {
    return {
      spacings: [],
      currentSpacingComponent: null,
      spacingParams: {},
      default_params: {
        plot_size: 3,
        selected_boxes: [],
        sqf: {
          width: 30,
          units: 16
        }
      }      
    }
  },
  mounted: function() {
    // this.currentSpacingComponent = PoxSqfSquareShape

    this.$http.get('/items/' + this.item.id + '/spacings').then(response => {
      this.spacings = response.body
    }, response => {

    })

  },
  methods: {
    editSpacing: function(spacing) {  
      this.currentSpacingComponent = null
      this.spacingParams = spacing;
      this.currentSpacingComponent = "pox-sqf-" + spacing.spacing + "-shape"
    },
    extendPlot: function(newPlotSize) {
      if (newPlotSize <= 7)
        this.default_params.plot_size = newPlotSize
    },
    newSpacing: function(spacing) {

      this.$http.get('/spacings/' + spacing + '/new').then(response => {
        this.spacingParams = response.body
        this.currentSpacingComponent = "pox-sqf-" + spacing + "-shape"

      }, response => {

      })
    },
    isSelected: function(col, row) {
      return this.default_params.selected_boxes.find(box => box.col === col && box.row === row)
    },
    setSelectedBoxes: function(selected_boxes) {
      this.default_params.selected_boxes = selected_boxes
    },
    setSqfMaxItem: function(unit) {
      this.spacingParams.max_items += unit
      if (this.spacingParams.max_items === 0)
        this.spacingParams.max_items = 1
      else
        this.setSqfMinItem(unit)
    },
    setSqfMinItem: function(unit) {
      this.spacingParams.min_items += unit

      if (this.spacingParams.min_items === 0)
        this.spacingParams.min_items = 1


    },
    setSqfCostItem: function(unit) {
      this.spacingParams.cost_in_unit += unit
      
      if (this.spacingParams.cost_in_unit === 0) {
      
        this.spacingParams.cost_in_unit = 1
        
      } else if (this.spacingParams.cost_in_unit === (this.default_params.sqf.units + 1)) {
        this.spacingParams.cost_in_unit = this.default_params.sqf.units
        
      } else {
      
        let res = parseInt(this.default_params.sqf.units / this.spacingParams.cost_in_unit)
        this.spacingParams.max_items = res
        this.spacingParams.min_items = res     
      }
    },
    submitSpacing: function(spacing) {

      if (spacing.spacing_id === null) {
        this.$http.post('/items/' + this.item.id + '/spacings', 
          {options: spacing.options}).then(response => {
          
          this.spacings.push(response.body)
        }, response => {

        })
      } else {
        this.$http.put('/items/' + this.item.id + '/spacings/' + spacing.spacing_id, 
          {options: spacing.options}).then(response => {
          let edited_spacing = this.spacings.find(tmp_spacing => spacing.spacing_id == tmp_spacing.spacing_id)

          this.spacings.splice(this.spacings.indexOf(edited_spacing), 1)
          this.spacings.push(response.body)
          // this.spacingParams = null
          

        }, response => {

        })
      }
    },
  },
  computed: {
    classPlot: function() {
      if (this.default_params.plot_size === 3)
        return 'plot-150-boxes'
      else if (this.default_params.plot_size === 4)
        return 'plot-120-boxes'
      else if (this.default_params.plot_size === 5)
        return 'plot-90-boxes'
      else if (this.default_params.plot_size === 6)
        return 'plot-80-boxes'
      else if (this.default_params.plot_size === 7)
        return 'plot-60-boxes'
    }
    // default_params: function() {
    //   return {
    //     plot_size: 3,
    //     selected_boxes: [],
    //     sqf: {
    //       width: 30,
    //       units: 16
    //     }
    //   }      
    // }
  }
}

</script>

<style lang="scss">

.plot-150-boxes {
  .box {
    width: 150px;
    height: 150px;
  }
  
  .scale-default {
    position: absolute;
    left: 150px;
  }

}

.plot-120-boxes {
  .box {
    width: 120px;
    height: 120px;
  }
  .scale-default {
    position: absolute;
    left: 120px;
  }  
}

.plot-90-boxes {

  .box {
    width: 90px;
    height: 90px;
  }
  .scale-default {
    position: absolute;
    left: 90px;
  }  
}

.plot-80-boxes {
  .box {
    width: 80px;
    height: 80px;
  }
  .scale-default {
    position: absolute;
    left: 80px;
  }  
}

.plot-60-boxes {
  .box {
    width: 60px;
    height: 60px;
  }
  .scale-default {
    position: absolute;
    left: 60px;
  }  
}

.plot-30-boxes {
  .box {
    width: 30px;
    height: 30px;
  }
  .scale-default {
    position: absolute;
    left: 30px;
  }  
}

.box {
  border: 1px black solid;
  display: inline-flex;  
}



.selected {
  background: red;
}

.scale {
  position: absolute;
  color: grey;
  top: -1.5em;
}

.scale-hor {
  width:452px;
}


.scale-max {
  position: absolute;
  right: 0;
}

.units {
  display: flex-inline;

  span {
    width: 20px;
    height: 20px;
  }
}

</style>