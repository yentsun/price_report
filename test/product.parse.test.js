// Generated by CoffeeScript 1.10.0
(function() {
  var assert, log_mode, options, product, seneca;

  assert = require('chai').assert;

  options = {
    test: true
  };

  log_mode = process.env.TEST_LOG_MODE || 'quiet';

  seneca = require('seneca')({
    log: log_mode
  }).use('../product', options);

  product = seneca.pin({
    role: 'product',
    cmd: '*'
  });

  describe('parse', function() {
    it('parses a simple milk title', function(done) {
      return product.parse({
        title: 'Молоко Great Milk 3% 1L'
      }, function(error, data) {
        assert.equal(data.origin, 'Молоко Great Milk 3% 1L');
        assert.equal(data.title, 'молоко great milk');
        assert.equal(data["package"].amount, 1);
        assert.equal(data["package"].unit, "l");
        assert.equal(data.percentage, 3);
        return done();
      });
    });
    it('parses a milk title with spec chars', function(done) {
      return product.parse({
        title: 'МОЛОКО БИОСНЕЖКА 2.5% п\п 900гр'
      }, function(error, data) {
        assert.equal(data.origin, 'МОЛОКО БИОСНЕЖКА 2.5% п\п 900гр');
        assert.equal(data.title, 'молоко биоснежка п\п');
        assert.equal(data["package"].amount, 900);
        assert.equal(data["package"].unit, "g");
        assert.equal(data.percentage, 2.5);
        return done();
      });
    });
    it('parses a milk title with percentage range', function(done) {
      return product.parse({
        title: 'Молоко Простоквашино отборное пастеризованное 3,4-4,5%, 0,93л'
      }, function(error, data) {
        assert.equal(data["package"].amount, 0.93);
        assert.equal(data["package"].unit, "l");
        assert.equal(data.percentage[0], 3.4);
        assert.equal(data.percentage[1], 4.5);
        return done();
      });
    });
    return it('parses a messy milk title', function(done) {
      return product.parse({
        title: 'Молоко пастериз.1% 1л Лосево'
      }, function(error, data) {
        assert.equal(data["package"].amount, 1);
        assert.equal(data["package"].unit, "l");
        assert.equal(data.percentage, 1);
        return done();
      });
    });
  });

}).call(this);

//# sourceMappingURL=product.parse.test.js.map
