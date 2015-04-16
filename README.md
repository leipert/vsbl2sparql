# vsbl2sparql

This package allows to parse JSONs created by the Visual SPARQL Builder and translate them to SPARQL. It is available as angular module via bower and as node module/standalone via npm.

## Example

```json
{
  "CONFIG": "DBPEDIA_CONFIG",
  "START": {
    "type": "LIST_ALL",
    "linkTo": "person"
  },
  "SUBJECTS": [
    {
      "uri": "http://dbpedia.org/ontology/Person",
      "view": true,
      "alias": "person",
      "properties": []
    }
  ]
}
```
translates to
```SPARQL
Select Distinct ?person {?person <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://dbpedia.org/ontology/Person>}
```

## standalone usage

```bash
npm install -g vsbl2sparql
cat example.json | vsbl2sparql # Read from stdin, write to stdout
cat example.json | vsbl2sparql -o example.sparql # Read from stdin, write to example.sparql
vsbl2sparql example.json # Read from file, write to stdout
vsbl2sparql example.json -o example.sparql # Read from file, write to example.sparql
#Alternative reading from file:
vsbl2sparql < example.json > example.sparql
```

## npm usage

```bash
npm install vsbl2sparql
```

```javascript
var vsbl2sparql = require('vsbl2sparql');

var json = JSON.parse('{"CONFIG":"foo","START":{"type":"LIST_ALL","linkTo":"person"},"SUBJECTS":[{"uri":"http://dbpedia.org/ontology/Person","view":true,"alias":"person","properties":[]}]}');

console.log(
  vsbl2sparql.translateJSONToSPARQL(json).toString()
);

```

## angular usage
```bash
bower install vsbl2sparql
```

```html
<html ng-app="app">
<head>
  <style>textarea {width: 450px;height:200px}</style>
</head>
<body ng-controller="appController">

<textarea ng-model="json"></textarea>
<textarea ng-model="sparql" disabled></textarea>

<script src="bower_components/bluebird/js/browser/bluebird.js"></script>
<script src="bower_components/jassa/jassa.js"></script>
<script src="bower_components/angular/angular.js"></script>
<script src="bower_components/vsbl2sparql/vsbl2sparql-angular.js"></script>

<script>
angular.module('app',['VSBL2SPARQL'])
  .controller('appController',function($scope, VSBL2SPARQL){
    $scope.json = '{"CONFIG":"foo","START":{"type":"LIST_ALL","linkTo":"person"},"SUBJECTS":[{"uri":"http://dbpedia.org/ontology/Person","view":true,"alias":"person","properties":[]}]}'

    $scope.sparql = VSBL2SPARQL.translateJSONToSPARQL($scope.json).toString()

    $scope.$watch($scope.json,function(json){
      $scope.sparql = VSBL2SPARQL.translateJSONToSPARQL(json).toString()
    });

  })
</script>
</body>
</html>
```
