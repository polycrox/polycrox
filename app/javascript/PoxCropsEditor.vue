<template>
  <div class='form-row'>
    <div class="col-12">
      New crop
    </div>

    <div class='col-12'>
      <input class='form-control' type="text" v-model="crop.qty" placeholder="qty" /> 
    </div>

    
    <div class='col-12'>
      <pox-search 
        v-on:pox-search-selected="selectItem($event)"></pox-search>
    </div>


    <div class='col-12'>
      <input class='form-control' type="text" v-model="crop.date" placeholder="e.g: 16 september 2017" />
    </div>

    <div class='col-12'>
      <button class="btn btn-primary" 
        v-on:click="submit()"
        v-bind:class="{ disabled: isFormReadyForSubmit() }">
        create
      </button>

    </div>
  </div>
</template>


<script>

import PoxPlotCrop from './PoxPlotCrop'

export default {
  components: {
    PoxPlotCrop
  },
  props: ['plot_id'],
  data: function () {
    return {
      crops: [],
      crop: {},
      prout: {
        toto: 1
      },
      showSearchItem: true
    }
  },
  mounted: function() {

  },
  computed: {  
  },
  methods: {
    isFormReadyForSubmit: function() {
      return this.crop.qty === undefined || this.crop.item === undefined || this.crop.date === undefined
    },
    selectItem: function(item) {
      this.crop.item = item      
    },
    cropToParams: function() {
      return {
        item_id: this.crop.item.id,
        date: this.crop.date
      }
    },
    submit: function() {
      this.$http.post('/plots/' + this.plot_id + '/crops', {qty: this.crop.qty, crop: this.cropToParams()}).then(response => {
        
        this.$emit('pox-update-crops', response.body)
        this.crop.qty = undefined


      }, response => {
        console.log('fail')
      })
    },
  },
  computed: {

  }
}
</script>

<style scoped>
</style>
