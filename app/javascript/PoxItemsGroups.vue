<template>
  <div>
    <h4>The database contains {{ groupsCount }} groups and {{ itemsCount }} items.</h4>

    <pox-search
      v-on:pox-search-selected='showItem($event)'>
    </pox-search>

    <pox-sqf-editor
      v-if='item'
      :item='item'>
      
    </pox-sqf-editor>

  </div>
</template>

<script>

export default {
  data: function() {
    return {
      groups: [],
      groupsCount: 0,
      itemsCount: 0,
      item: null
    }
  },
  methods: {
    showItem: function(item) {
      // this.item = item
      window.location.href = '/items/' + item.id
      
    },
    getGroupsCount: function() {
      this.$http.get('/groups/count').then(response => {
        this.groupsCount = response.body
      })
    },
    getItemsCount: function() {
      this.$http.get('/items/count').then(response => {
        this.itemsCount = response.body
      })
    }    
  },
  mounted: function() {
    this.getGroupsCount()
    this.getItemsCount()

    this.$http.get('/groups').then(response => {
      this.groups = response.body
      
      // this.groups.forEach((group) => {
      //   console.log(group)
      //   this.$http.get('/groups/' + group.id + '/items').then(response => {
      //     group.items = response.body
      //   }, response => {
      //     console.log('fail get items for group' + group.id)
      //   })
      // })
    }, response => {
      console.log('fail get groups')
    })
  }
}
</script>

<style>
</style>