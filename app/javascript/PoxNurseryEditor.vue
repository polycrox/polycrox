<template>
  <div class="row">
    <div class='col-sm-8'>
      <h2>Seeds</h2>
      <ul>
        <li v-for='(seed, index) in filterByType("Seed")'>
          {{ seed.quantity }} seeds of {{ seed.item.name }} "{{ seed.cultivar }}"
        </li>
      </ul>

      <h2>Seedlings</h2>
      <ul>
        <li v-for='(seedling, index) in filterByType("Seedling")'>
          {{ seedling.quantity }} seedlings of {{ seedling.item.name }} "{{ seedling.cultivar }}" created the {{ seedling.birthdate }}
        </li>
      </ul>

      <h2>Cuttings</h2>
      <ul>
        <li v-for='(cutting, index) in filterByType("Cutting")'>
          {{ cutting.quantity }} cuttings of {{ cutting.item.name }} "{{ cutting.cultivar }}"
        </li>
      </ul>            

    </div>
    <div class="col-sm-4">
      <h3>Add an item to the nursery</h3>

      <pox-nursery-item-form
        :nursery='nursery'
        v-on:pox-update-nursery-items='updateNurseryItems($event)'
        >
      </pox-nursery-item-form>
    </div>
  </div>
</template>

<script>

export default {
  props: ['nursery'],
  data: function() {
    return {
      items: []
    }
  },
  created: function() {
    this.$http.get('/gardens/' + this.nursery.garden_id + '/nursery/nursery_items').then(response => {
      this.items = response.body
    })
  },
  methods: {
    updateNurseryItems: function(item) {
      this.items.push(item)
    },
    filterByType: function(type) {
      return this.items.filter(item => item.type === type)
    }
  }
}
</script>