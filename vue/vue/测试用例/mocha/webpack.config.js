
//To let mocha run es6 code

var webpack = require('webpack');
var path = require("path");

module.exports = {
    context: path.resolve(__dirname),
    entry: './test.js',
    output: {
        path: path.resolve(__dirname, './'),
        filename: 'bundle.js'
    },
    module: {
        rules: [
            { test: /\.js$/, loader: 'babel-loader' }
        ]
    },
    mode: process.env.NODE_ENV ? process.env.NODE_ENV : 'production',
    watch: true,
    devServer: {
        contentBase: path.join(__dirname, './'),
        compress: true,
        port: 9999
    }
}