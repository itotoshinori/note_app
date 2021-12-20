import Vue from 'vue';
import VueRouter from 'vue-router';

// ルート用のコンポーネントを読み込む
import TopIndex from "../pages/top/index.vue";
import TaskIndex from "../pages/task/index.vue";

Vue.use(VueRouter)

const router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: TopIndex,
      name: "TopIndex"
  },
  {
    path: '/tasks',
    component: TaskIndex,
    name: "TaskIndex"
  }
]
})

export default router