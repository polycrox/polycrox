<template>

  
    <div class="row">
      <div class="col">
        This plot contains:
        <table class="table">
          <thead>
            <tr>
              <th scope="col">item name</th>
              <th scope="col">entry date</th>
              <th scope="col">state</th>
              <th scope="col">position</th>
              <th scope="col">actions</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for='(crop, index) in presentCrops'>
              <td>{{ crop.item.name }}</td>
              <td>{{ crop.date }}</td>
              <td>{{ crop.state }}</td>
              <td>{{ crop.position }}</td>
              <td><button v-on:click='togglePresence(crop)'>remove from plot</button></td>
            </tr>
          </tbody>
        </table>

        Plot's history
        <table class="table">
          <thead>
            <tr>
              <th scope="col">item name</th>
              <th scope="col">entry date</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for='(crop, index) in pastCrops'>
              <td>{{ crop.item.name }}</td>
              <td>{{ crop.date }}</td>
              <td>{{ crop.state }}</td>
              <td>{{ crop.position }}</td>
            </tr>
          </tbody>          
        </table>
      </div>


      <div class="col-sm-2">
        <pox-crops-editor 
          :plot_id='plot.id'
          v-on:pox-update-crops='updateCrops($event)'>
        </pox-crops-editor>
      </div>

    </div>

</template>

<script>


export default {
  props: ['garden', 'plot', 'boxes'],
  data: function () {
    return {
      crops: []
    }
  },
  created: function() {
    this.$http.get('/plots/' + this.plot.id + '/crops').then(response => {
      this.crops = response.body 
    })

  },
  computed: {
    presentCrops: function() {
      return this.crops.filter(crop => crop.present_in_plot)
    },
    pastCrops: function() {
      return this.crops.filter(crop => !crop.present_in_plot)
    }
  },
  methods: {
    togglePresence: function(crop) {

      this.$http.put('/plots/' + this.plot.id + '/crops/' + crop.id, {crop: {present_in_plot: !crop.present_in_plot}}).then(response => {
        crop.present_in_plot = !crop.present_in_plot
      })
    },
    updateCrops: function(crops) {

      crops.forEach((crop) => {
        console.log(crop)
        this.crops.push(crop)
      })
    },
    currentBox: function(x, y) {
      return this.boxes.find(box => box.pos_x === x && box.pos_y === y);
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
