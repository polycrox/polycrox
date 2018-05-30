<template>
  <div>
    <b>active</b>: {{ crop.date }} - <a v-on:click="deactivateActiveCrop()">deactivate</a>
    <pox-search :object='"item"' v-on:pox-search-submit="createItem($event, crop.id)"></pox-search>
  </div>
</template>

<script>
import PoxSearch from './PoxSearch'

export default {
  props: ['crop'],
  methods: {
    createItem: function(item, prout) {
      this.$emit('add-item-to-crop', {
        crop_id: this.crop.ip, 
        item: item
      })
    }
  }
}
</script>

<style scoped>

</style>