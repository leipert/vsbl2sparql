var assert = require('assert');

var glob = require('glob');

var JSON2SPARQL = require('../vsbl2sparql-node.js');

var files = glob.sync("fixtures/**/*.json", {cwd: process.cwd() + '/test'});

files.forEach(function (file) {

    var test = require('./' + file);

    describe(file + ':', function () {
        it(test.name, function () {
            assert.equal(JSON2SPARQL.translateJSONToSPARQL(test.json).toString(), test.result);
        })
    });
});
