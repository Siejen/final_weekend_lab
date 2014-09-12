# Define App and dependencies
TodoApp = angular.module("TodoApp", ["ngRoute", "templates"])

# Setup the angular router
TodoApp.config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
  $routeProvider
    .when '/',
      templateUrl: "index.html",
      controller: "TodosCtrl"
  .otherwise
      redirectTo: "/"

  $locationProvider.html5Mode(true)

]

# Todo Controller
TodoApp.controller "TodosCtrl", ["$scope", "$http", ($scope, $http) ->

  $scope.todos = []
]

# Define Config for CSRF token
TodoApp.config ["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]