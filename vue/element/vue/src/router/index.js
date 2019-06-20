import Vue from "vue";
import Router from "vue-router";

const IndexPage = resolve => require(["@/components/index"], resolve);
const Input = resolve => require(["@/components/input"], resolve);
const Jsx = resolve => require(["@/components/jsx"], resolve);
const Transfer = resolve => require(["@/components/transfer"], resolve);
import Copper from "@/components/copper" 

Vue.use(Router);

export default new Router({
  mode: "history",
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
          path: "/jsx",
          name: "Jsx",
          component: Jsx
        },
        {
          path: "/copper",
          name: "vueCopper",
          component: Copper
        },
        { path: "*", component: Input }
      ],
      redirect: "/input"
    }
  ]
});
