import Vue from 'vue'
import Router from 'vue-router'

import Input from '@/components/Input'
import Transfer from '@/components/transfer'
import Jsx from '@/components/jsx'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/input',
      name: 'input',
      component: Input
    },
    {
      path: '/transfer',
      name: 'transfer',
      component: Transfer
    },
    {
      path: '/jsx',
      name: 'Jsx',
      component: Jsx
    }
  ]
})
