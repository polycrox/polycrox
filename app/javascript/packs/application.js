/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import Vue from 'vue'
import VueResource from 'vue-resource'
import Vuex, { mapState } from 'vuex'

import App from '../App'
import PoxPlotsEditor from '../PoxPlotsEditor'
import PoxSearch from '../PoxSearch'
import PoxCropsEditor from '../PoxCropsEditor'

import PoxSqfEditor from '../PoxSqfEditor'
import PoxSqfSquareShape from '../PoxSqfSquareShape'
import PoxSqfCornerShape from '../PoxSqfCornerShape'

import PoxNurseryEditor from '../PoxNurseryEditor'
import PoxNurseryItemForm from '../PoxNurseryItemForm'

import PoxItemsGroups from '../PoxItemsGroups'

import PoxGardenMap from '../PoxGardenMap'
import store from './store'

Vue.use(VueResource)

Vue.component('app', App)
Vue.component('pox-plots-editor', PoxPlotsEditor)
Vue.component('pox-search', PoxSearch)
Vue.component('pox-crops-editor', PoxCropsEditor)
Vue.component('pox-sqf-editor', PoxSqfEditor)
Vue.component('pox-sqf-square-shape', PoxSqfSquareShape)
Vue.component('pox-sqf-corner-shape', PoxSqfCornerShape)
Vue.component('pox-nursery-item-form', PoxNurseryItemForm)
Vue.component('pox-items-groups', PoxItemsGroups)
Vue.component('pox-nursery-editor', PoxNurseryEditor)
Vue.component('big-counter', {
  template: `<h1>{{ count }}</h1>`,
  computed: {
    ...mapState([
      'count'
    ])
  }
})

Vue.component('pox-garden-map', PoxGardenMap)

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '[data-behaviour="vue"]',
    store
  })
})
