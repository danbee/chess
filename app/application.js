"use strict";

import Vue from "vue";

import App from 'components/app';
import store from "store";

class Main {
  constructor() {
    new Vue({
      el: '#app',
      store,
      render: h => h(App)
    });
  }
};

export default new Main;
