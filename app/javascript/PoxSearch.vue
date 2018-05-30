<template>
  <select class='custom-select' v-model='selectedItem' v-on:change='sendEvent()'>
    <option disabled selected>choose item</option>
    <option 
      v-for='(item, index) in items'
      v-bind:value="item">
      {{ item.name }}
    </option>
  </select>
<!--   <div class='form-group' v-if='ui.showInput'>
    <label v-if='label'>{{ label }}</label>
    <input 
      placeholder='search for an item' type="text" class='form-control' v-model="token" 
      v-on:keyup="searchAutocomplete($event)" 
      v-on:keyup.delete="clearResults()"
      v-on:keyup.down.stop="moveSelection(1)"
      v-on:keyup.up.stop="moveSelection(-1)"
      v-on:keyup.enter="submit()" />

    <div v-if="completions">
      <div v-if="completions.length > 0">
        results
        <ul>
          <li v-for="(item, index) in completions">
            {{ item.name }}
            <span style="color:red" v-if="item._selected">
              selected
            <span v-if='ui.showEdit'>
              <a v-bind:href='"/items/" + item.id'>edit</a>
            </span>

            </span>

          </li>
        </ul>
      </div>
      <div v-if="completions.groups">
        groups: 
        <ul>
          <li v-for="(group, index) in completions.groups">
            {{ group.name }}
            items: {{ group.items }}
            <ul>
              <li v-for="(item, index) in group.items">
                {{ item.name }}
              </li>
            </ul>

          </li>
        </ul>
      </div>
    </div>
  </div> -->
  
</template>

<script>
export default {
  props: ['label', 'object', 'options'],
  data: function() {
    return {
      items: [],
      selectedItem: null,
      token: null,
      completions: [],
      ui: {
        showInput: true,
        showResult: false,
        showEdit: false,
      }
    }
  },
  mounted: function() {
    this.$http.get('/items').then(response => {
      this.items = response.body
    })
    // if (this.options && this.options.showEdit)
    //   this.ui.showEdit = this.options.showEdit
  },
  computed: {
    selectedObject: function() {
      return this.completions.find(object => object._selected)
    },
    selectedObjectIndex: function() {
      return this.completions.indexOf(this.selectedObject)
    },    
  },
  methods: {
    sendEvent: function() {
      this.$emit('pox-search-selected', this.selectedItem)
    },
    autoCompletion: function(token) {
      this.$http.post('/objects/' + this.object, {object_search: {token: token}}).then(response => {
        let _this = this
        _this.completions = []
        response.body.items.forEach(function(item, index) {
          if (index === 0)
            item._selected = true
          else
            item._selected = false

          _this.completions.push(item)
        })
      }, response => {
        console.log(response)
      })
    },
    keyUp: function() {
      console.log('up ' + this.token)
    },
    searchAutocomplete: function(event) {
      if (event.key >= "a" && event.key <= "z") {
        if (typeof(this.token) == null) {
          return   
        } else {
          if (this.token.length > 0) {
            this.autoCompletion(this.token)
          }
        }
      }
    },
    clearResults: function() {
      if (this.token.length === 0) {
        this.completions = []
      } else {
        this.autoCompletion(this.token)
      }
    },
    moveSelection: function(pos) {
      let next = pos + this.selectedObjectIndex
      if (next === this.completions.length || next === -1) {
        next = 0
      }
      this.selectedObject._selected = false
      this.completions[next]._selected = true
    },
    submit: function() {
      if (this.selectedObject) {
        this.$emit('pox-search-submit', this.selectedObject)
        this.completions = []
        this.token = null
        if (this.options && this.options.hide_input)
          this.ui.showInput = false
      }
    }
  }
  
}


</script>

<style scoped>
#bonjour ul {
  border: 1px solid black;
}
</style>