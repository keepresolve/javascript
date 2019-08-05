module.exports = {
    env: {
        browser: true,
        commonjs: true,
        es6: true,
        node: true
    },
    extends: [
        'eslint:recommended', // 代码规范
        'plugin:prettier/recommended'
    ],
    parser: 'babel-eslint',
    parserOptions: {
        // ecmaVersion: 6,       // 指定ECMAScript支持的版本，6为ES6
        sourceType: 'module' // 指定来源的类型，有两种”script”或”module”
    },
    rules: {
        //  0 = off, 1 = warn, 2 = error
        'no-console': 0,
        'no-fallthrough': 0, // 禁止case语句落空
        'no-irregular-whitespace': 0
    },
    //全局对象  eslint 警告
    globals: {
        ActiveXObject: false,
        logger: true,
        app: true
    }
}
