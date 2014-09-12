# Define App and dependencies
HangmanApp = angular.module("HangmanApp", ["ngRoute", "templates"])

# Setup the angular router
HangmanApp.config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
  $routeProvider
    .when '/',
      templateUrl: "index.html",
      controller: "GamesCtrl"
  .otherwise
      redirectTo: "/"

  $locationProvider.html5Mode(true)

]

# Games Controller
GamesApp.controller "GamesCtrl", ["$scope", "$http", ($scope, $http) ->

  $scope.games = []
]

# Define Config for CSRF token
HangmanApp.config ["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]