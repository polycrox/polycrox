<template>
  <div>
    <h4>The database contains {{ groupsCount }} groups and {{ itemsCount }} items.</h4>
    <!-- <ul>
      <li v-for='(group, index) in groups'>
        {{ group.name }}
        <ul>
          <li v-for='(item, x_index) in group.items'>
          {{ item.name }}
          </li>
        </ul>
      </li>
    </ul> -->

    <pox-search
      :object='"items-groups"'
      :options='{showEdit: true}'
      v-on:pox-search-submit='showObject($event)'
      >
        
    </pox-search>
  </div>
</template>

<script>

export default {
  data: function() {
    return {
      groups: [],
      groupsCount: 0,
      itemsCount: 0
    }
  },
  methods: {
    showObject: function(object) {

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