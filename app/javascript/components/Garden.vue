<template>
  <div>
    <button type="button" class="btn btn-primary" v-on:click="displayForm">Create a Garden</button>
    <div v-if="this.create === 'true'">
      
      <hr />
    </div>

    <div v-if="this.index === 'true'">
      {{ this.gardens }}
    </div>
  </div>
</template>

<script>
import FormNewGarden from '../components/Fidji'

export default {
  name: 'Garden',
  components: {
    // Gardens
  },
  data: function () {
    return {
      item: {
        name: '',
        location: ''
      }
    }
  },
  created: function() {
    
  },
  methods: {

  }
}
</script>

<style scoped>
</style>
