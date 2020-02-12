/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb
import 'core-js/stable'
import 'regenerator-runtime/runtime'

import Vue from 'vue/dist/vue.esm.js'
import VueResource from 'vue-resource'
import Vuex, { mapState } from 'vuex'

import App from './components/App'
import PoxPlotsEditor from './components/PoxPlotsEditor'
import PoxSearch from './components/PoxSearch'
import PoxCropsEditor from './components/PoxCropsEditor'

import PoxSqfEditor from './components/PoxSqfEditor'
import PoxSqfSquareShape from './components/PoxSqfSquareShape'
import PoxSqfCornerShape from './components/PoxSqfCornerShape'

import PoxNurseryEditor from './components/PoxNurseryEditor'
import PoxNurseryItemForm from './components/PoxNurseryItemForm'

import PoxItemsGroups from './components/PoxItemsGroups'

import PoxGardenMap from './components/PoxGardenMap'
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
