var Promise = require('bluebird');
var request = Promise.promisifyAll(require('request'));

// create ajax function for sending requests
var ajax = function(param) {
    return request.postAsync(param.url, {
        json: true,
        form: param.data
    }).then(function(res) {
        return new Promise(function(resolve) {
            resolve(res[0].body);
        });
    });
};

var jassa = require('jassa-core')(Promise, ajax);

@@include('index.js')

module.exports = {
    translateJSONToSPARQL: translateJSONToSPARQL
};