<template>
  <div class="container">
    <div class="row">
      <garden class="col-sm"></garden>
      <fidji class="col-sm" create="true" index="true" source="global"></fidji>
    </div>
  </div>
</template>

<script>
import Garden from '../components/Garden'
import Fidji from '../components/Fidji'

export default {
  data: function () {
    return {
      message: "Hello Vue!"
    }
  },
  components: {
    Garden,
    Fidji
  }
}

</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
