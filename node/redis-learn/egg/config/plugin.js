"use strict";

/** @type Egg.EggPlugin */
module.exports = {
  // had enabled by egg
  // static: {
  //   enable: true,
  // }
  redis: {
    enabled: true,
    package: 'egg-redis',
  },
};
