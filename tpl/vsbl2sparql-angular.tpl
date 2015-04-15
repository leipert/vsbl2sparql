(function () {
    'use strict';
    /**
     * JSON Translator Factory
     * A factory to handle translation of JSON -> SPARQL
     *
     */


    angular.module('VSBL2SPARQL', [])
        .factory('VSBL2SPARQL', VSBL2SPARQL);

    function VSBL2SPARQL() {

        var jassa = new Jassa(Promise, $.ajax);

@@include('index.js')

        return {
            translateJSONToSPARQL: translateJSONToSPARQL,
            translateJSONToSponateMap: translateJSONToSponateMap
        };

        function translateJSONToSponateMap(json) {
            aggregates = new sparql.VarExprList();
            objects = new sparql.VarExprList();
            main = '';

            shownVariables = new sparql.VarExprList();
            blockList = new sparql.VarExprList();
            var ElementTriplesBlock = new sparql.ElementTriplesBlock(), r;
            if (json.hasOwnProperty('SUBJECTS')) {
                json.SUBJECTS.forEach(function (subject) {
                    ElementTriplesBlock.addTriples(translateSubject(subject));
                });
            }

//ElementTriplesBlock.addTriples(aggregates);

            r = {
                name: new Date().toISOString(),
                template: [{
                    id: main.toString(),
                    rows: [{
                        id: '?rowId'
                    }]
                }],
                from: ElementTriplesBlock.toString()
            };

            getProjectVars().getVars().forEach(function (Var) {
                var key = Var.toString().replace(/^\?/, '');
                if (objects.contains(Var)) {
                    key = '$' + key;
                }
                r.template[0].rows[0][key] = Var.toString();
            });

            return r;
        }

    }

})();