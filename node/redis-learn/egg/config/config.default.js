/* eslint valid-jsdoc: "off" */

"use strict";

/**
 * @param {Egg.EggAppInfo} appInfo app info
 */
module.exports = (appInfo) => {
  /**
   * built-in config
   * @type {Egg.EggAppConfig}
   **/
  const config = (exports = {});

  // use for cookie sign key, should change to your own and keep security
  config.keys = appInfo.name + "_1606816434953_8076";

  // add your middleware config here
  config.middleware = [];
  config.static = {
   
    // maxAge: 31536000,
  };
  config.cluster = {
    listen: {
      path: '',
      port: 8000,
      hostname: '0.0.0.0',
    }
};
  config.redis = {
    clients: {
      client1: {                 // instanceName. See below
        port: 6379,          // Redis port
        host: '127.0.0.1',   // Redis host
        password: '',
        db: 0,
      },
      client2: {
        port: 6379,
        host: '127.0.0.1',
        password: '',
        db: 0,
      },
    }
  }

  // add your user config here
  const userConfig = {
    // myAppName: 'egg',
  };

  return {
    ...config,
    ...userConfig,
  };
};
