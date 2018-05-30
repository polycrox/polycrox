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
import App from '../App'
import PoxEditor from '../PoxEditor'
import PoxEditorCanvas from '../PoxEditorCanvas'
import PoxSearch from '../PoxSearch'
import Crops from '../Crops'

import PoxSqfEditor from '../PoxSqfEditor'
import PoxSqfSquareShape from '../PoxSqfSquareShape'
import PoxSqfCornerShape from '../PoxSqfCornerShape'

import PoxNurseryItemForm from '../PoxNurseryItemForm'

import PoxItemsGroups from '../PoxItemsGroups'

Vue.use(VueResource)

Vue.component('app', App)
Vue.component('pox-editor', PoxEditor)
Vue.component('pox-search', PoxSearch)
Vue.component('pox-editor-canvas', PoxEditorCanvas)
Vue.component('crops', Crops)
Vue.component('pox-sqf-editor', PoxSqfEditor)
Vue.component('pox-sqf-square-shape', PoxSqfSquareShape)
Vue.component('pox-sqf-corner-shape', PoxSqfCornerShape)
Vue.component('pox-nursery-item-form', PoxNurseryItemForm)
Vue.component('pox-items-groups', PoxItemsGroups)

document.addEventListener('DOMContentLoaded', () => {
  
  const app = new Vue({
    el: '[data-behaviour="vue"]'
  })
})
