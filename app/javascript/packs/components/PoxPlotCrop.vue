<template>
  <div class="col-sm-12">

    <h4>{{ crop.date }}</h4>
    
    <br />
    <div v-if="items.length == 0">
    No Items
    </div>
    <div v-else>
      Items:
      <ol>
        <li v-for="(item, index) in items">
          {{ item.name }}
        </li>
      </ol>
    </div>

    <pox-search 
      :label='"add an item"'
      :object='"item"' 
      v-on:pox-search-submit="createItem($event)"></pox-search>
  </div>
</template>

<script>

export default {
  props: ['crop', 'plot_id'],
  data: function() {
    return {
      items: []
    }
  },
  mounted: function() {
    this.$http.get('/plots/' + this.plot_id + '/crops/' + this.crop.id + '/items').then(response => {
      this.items = response.body
    }, response => {
      console.log('index_items failed for plot_id', this.plot_id)
    })
  },
  methods: {
    activateCrop: function() {

    },
    deleteCrop: function() {

    },
    createItem: function(item) {
      let _this = this
      this.$http.post('/plots/' + _this.plot_id + '/crops/' + _this.crop.id + '/items', {item_id: item.id}).then(response => {
          _this.items.push(item)
        // if (_this.crops.active != null) {
        //   if (_this.crops.active.id === crop_id) {
        //     _this.crops.active.items.push(item)
        //   } else {
        
        //     let crop = _this.crops.past.find(crop => crop.id === crop_id)
        //     console.log("je suis ici")
        //     crop.items.push(item)
        //   }  
        // }
      }, response =>{
        console.log('fail createItem')
      })
    }    
  }
}

</script>


<style>

</style>