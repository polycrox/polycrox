<template>

  <div class="container">
    <div class="row">
      <div class="col-sm-2 boxes">
        <div v-for="(x, x_index) in plot.rows" class="row no-gutters">
          <div v-for="(y, y_index) in plot.cols" class="col card">
            {{ x }} / {{ y }}
            {{ currentBox(x, y).id }}
          </div>
        </div>
      </div>

      <div class="col-sm crops">
        <h2>Past crops</h2>
        <crops 
          :plot_id='plot.id'>
        </crops>
      </div>

      <div class="col-sm simulation">
        <h2>Simulations</h2>
        
      </div>      

    </div>
on ne peut pas manuellement activer une crop
car le but du programme n’est pas de positionner manuellement les items dans le plot suivant la méthode Square foot box

pour l’instant on veut seulement rentrer l’historique du plot, la dernière crop

et ensuite générer une prochaine crop basé sur l’historique
cette crop pour ce plot sera Square Foot positionned

  </div>
</template>

<script>


export default {
  props: ['garden', 'plot', 'boxes'],
  data: function () {
    return {
    }
  },
  created: function() {

  },
  computed: {
  },
  methods: {
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
