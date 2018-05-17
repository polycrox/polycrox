<template>
  <div>
    <div v-if="this.create === 'true'">
      <button type="button" class="btn btn-primary">Create a Fidji</button>
      <hr />
    </div>

    <div v-if="this.index === 'true'">
      {{ this.fidjis }}
    </div>
  </div>
</template>

<script>
export default {
  name: 'Fidji',
  props: ['create', 'index'],
  data: function () {
    return {
      fidjis: []
    }
  },
  created: function() {
    console.log(this.create)
    console.log(this.index)
    this.fidjis.push("toto")
  },
  methods: {

  }
}
</script>

<style scoped>
</style>
