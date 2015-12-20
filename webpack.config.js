var path = require('path');
var webpack = require('webpack');

module.exports = {
  devtool: 'eval',
  entry: "./app/app.coffee",
  output: {
    path: path.join(__dirname, '/public'),
    filename: 'bundle.js',
  },
  plugins: [
    new webpack.HotModuleReplacementPlugin()
  ],
  module: {
    loaders: [
      {test: /\.coffee$/, loader: 'coffee'}
    ]
  },
  resolve: {
    extensions: ["", ".js", ".coffee"]
  }
};
