import Vue from "vue";
import Router from "vue-router";

const IndexPage = resolve => require(["@/components/index"], resolve);
const Input = resolve => require(["@/components/input"], resolve);
const Jsx = resolve => require(["@/components/jsx"], resolve);
const Transfer = resolve => require(["@/components/transfer"], resolve);
const TransferPage = resolve => require(["@/components/transferPage"], resolve);
const iScroll = resolve => require(["@/components/iScroll"], resolve);
const Table = resolve => require(["@/components/Table"], resolve);
const Directives = resolve => require(["@/components/directives"], resolve);
import Copper from "@/components/copper";

Vue.use(Router);

export default new Router({
  mode: "history",
  // base: "/test/",
  routes: [
    {
      path: "/",
      name: "index",
      component: IndexPage,
      children: [
        {
          path: "/input",
          name: "input",
          component: Input
        },
        {
          path: "/transfer",
          name: "transfer",
          component: Transfer
        },
        {
          path: "/transferpage",
          name: "transferpage",
          component: TransferPage
        },
        {
          path: "/jsx",
          name: "Jsx",
          component: Jsx
        },
        {
          path: "/copper",
          name: "vueCopper",
          component: Copper
        },
        {
          path: "/iscroll",
          name: "iScroll",
          component: iScroll
        },
        {
          path: "/table",
          name: "table",
          component: Table
        },
        {
          path:"directives",
          name: "directives",
          component:  Directives,
         
        },
        { path: "*", component: Input }
      ],
      redirect: "/input"
    }
  ]
});
