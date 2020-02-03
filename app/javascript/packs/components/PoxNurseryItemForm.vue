<template>
  <div class="row">
    <div class="col-sm">
    
    <div class='form-group'>
      <label>
      Type
      </label>
      <select v-model='nurseryItem.type' class='form-control'>
        <option v-for='type in nurseryItemTypes'>
          {{ type }}
        </option>
      </select>
    </div>
  
  <!-- nursery.item -->
  <div class='form-group'>
    <label>Item</label>
     
    <pox-search
      v-on:pox-search-selected="selectItem($event)">    
    </pox-search>
  </div>
  <!-- code a search or create component -->
  <!-- pox-search -->
  <div class='form-group'>
    <label>cultivar</label>
    <input placeholder="cultivar" type="text" class='form-control' v-model='nurseryItem.cultivar' />
  </div>

  <div class='form-group'>
    <label>quantity</label>
    <input type="integer" class='form-control' v-model='nurseryItem.quantity' />
  </div>


  <div class='form-group' v-if='nurseryItem.type != "Seed"'>
    <label>birthdate</label>
    <input type="text" class='form-control' v-model='nurseryItem.birthdate' />
  </div>

  <!-- <div class="form-group" v-if='nurseryItem.type != "Seed"'>
    <label class="">happiness</label>
    <br />
    <div class="form-check form-check-inline" v-for="i in 5">
      <input type="radio" class="form-check-input" v-bind:value='i' v-model='nurseryItem.happiness' />
      <label class='form-check-label'>{{ i }}</label>
    </div>
  </div> -->

  <button class="btn btn-primary" v-on:click='submitForm()'>create</button>
  </div>
  </div>
</template>

<script>

export default {
  props: ['nursery'],
  data: function() {
    return {
      nurseryItem: {},
      nurseryItemTypes: ['Seed', 'Seedling', 'Cutting'],
      showSearchItem: true
    }
  },
  mounted: function() {
    this.$http.get('/gardens/' + this.nursery.garden_id + '/nursery/nursery_items/new').then(response => {
      this.nurseryItem = response.body
      this.nurseryItem.nursery_id = this.nursery.id
    }, response => {

    })
  },
  methods: {
    selectItem: function(item) {
      this.nurseryItem.item_id = item.id
      this.nurseryItem.item = item
    },
    submitForm: function() {
      this.$http.post('/gardens/' + this.nursery.garden_id + '/nursery/nursery_items', {nursery_item: this.nurseryItem}).then(response => {
        this.$emit('pox-update-nursery-items', response.body)
      }, response => {
        console.log('fail submitForm nurseryItem')
      })
    }
  },
  computed: {
  }
}
</script>

<style scoped>

</style>