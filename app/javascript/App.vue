<template>
  <div>
    {{ plot }}
  </div>
</template>

<script>
export default {
  props: ['plot'],
  data: function () {
    return {
      message: "Hello Vue!"
    }
  },
  created: function() {
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
