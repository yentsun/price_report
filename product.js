// Generated by CoffeeScript 1.10.0
(function() {
  var parse;

  parse = require('./product/parse');

  module.exports = function(options) {
    var role, seneca;
    seneca = this;
    role = 'product';
    seneca.add("role:" + role + ",cmd:parse", parse(seneca, options));
    return role;
  };

}).call(this);

//# sourceMappingURL=product.js.map
