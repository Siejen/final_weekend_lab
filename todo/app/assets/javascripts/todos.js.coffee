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

  $scope.tasks = []
  $scope.name = "Walk the Dog"
  $scope.due_date = "2014-09-20"
  $scope.task_complete = false

  $scope.getTasks = ->
    console.log("this is happening")
    $http.get("/todos.json").success (data) ->
      console.log("this is also happening")
      $scope.tasks = data

  $scope.getTasks()

]


# Define Config for CSRF token
TodoApp.config ["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]