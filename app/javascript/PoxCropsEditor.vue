<template>
  <div class="row">
<!--     permanent items
    item - position_in_plot - remove
    input pox-search.object(item), age,  create
 -->
    <h2>Past crops</h2>
    <pox-plot-crop v-for="(crop, index) in crops" :crop='crop' :plot_id='plot_id'>
    </pox-plot-crop>
    <hr />
    <div class="col-sm-12">
      Add a past crop
      <form class="form-inline">
        <div class="form-group">

          <input class='form-control' type="text" v-model="crop.date" placeholder="e.g: 16 september 2017" />
        </div>
        <button class="btn btn-primary" 
          v-on:click="submit()"
          v-on:keyup.enter="submit()">create</button>

      </form>
    </div>
    
    
  </div>

  <!-- <div v-if="crops.active"> -->
    <!-- <active-crop :crop='crops.active'></active-crop> -->
    <!-- <b>active</b>: {{ crops.active.date }} - <a v-on:click="deactivateActiveCrop()">deactivate</a> -->
    <!-- <br /> -->
    <!-- Items: -->
<!--     <ol>
      <li v-for="(item, index) in crops.active.items">
        {{ item.name }}
      </li>
    </ol>     -->
    
<!--     <pox-search 
      :label='"add an item"'
      :object='"item"' 
      v-on:pox-search-submit="createItem($event, crops.active.id)"></pox-search> -->

    
  <!-- </div> -->
  <!-- <b>pasts:</b> -->
  <!-- <ul> -->
    <!-- <li v-for="(crop, index) in crops.past"> -->
      <!-- <crop :crop='crop'></crop> -->
      <!-- {{ crop.date }} - <a v-on:click="activateCrop(crop.id, index)">activate</a> - <a v-on:click="deleteCrop">delete</a> -->
      <!-- <br /> -->
      <!-- Items: -->
      <!-- <ol> -->
        <!-- <li v-for="(item, index) in crop.items"> -->
          <!-- {{ item.name }} -->
        <!-- </li> -->
      <!-- </ol> -->

      <!-- <pox-search  -->
        <!-- :object='"item"'  -->
        <!-- v-on:pox-search-submit="createItem($event, crop.id)"></pox-search> -->
    <!-- </li> -->
  <!-- </ul> -->

  <!-- 
  permanent items
    item - position_in_plot - remove
    input pox-search.object(item), age,  create
 
  position_in_plot allows to add an item to a box
  (in past_crop mode, no square foot box validations needed. we just want to add what was in the plot)
  (in past_crop mode, we dont really need to position an item in the plot)
  -->

</template>


<script>

import ActiveCrop from './ActiveCrop'
import PoxPlotCrop from './PoxPlotCrop'

export default {
  components: {
    ActiveCrop,
    PoxPlotCrop
  },
  props: ['plot_id'],
  data: function () {
    return {
      crops: [],
      crop: {
        date: ''
      },
    }
  },
  mounted: function() {
    let _this = this
    this.$http.get('/plots/' + this.plot_id + '/crops').then(response => {
      _this.crops = response.body
      // _this.crops = {
      //   active: JSON.parse(response.body.active),
      //   past: JSON.parse(response.body.past)
      // }
    })
  },
  computed: {  
  },
  methods: {
    submit: function() {
      this.$http.post('/plots/' + this.plot_id + '/crops', {crop: this.crop}).then(response => {
        this.crops.push(response.body)
      }, response => {
        console.log('fail')
      })
    },
    deleteCrop:function() {

    },
    activateCrop: function(crop_id, index) {
      this.$http.put('/plots/' + this.plot_id + '/crops/' + crop_id, {crop: {active: true}}).then(response => {
        this.crops.active = response.body
        this.crops.past.splice(index, 1)
      }, response => {
        console.log("fail active")
      })
    },
    deactivateActiveCrop: function() {
      console.log(this.crops.active)
      let _this = this
      this.$http.put('/plots/' + this.plot_id + '/crops/' + this.crops.active.id, {crop: {active: false}}).then(response => {
        _this.crops.active = response.body
        _this.crops.past.push(_this.crops.active)
        _this.crops.active = null
      })
    },
  }
}
</script>

<style scoped>
</style>
