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
HangmanApp.controller "GamesCtrl", ["$scope", "$http", ($scope, $http) ->

  $scope.games = []
  $scope.hiddenWord = '';
  $scope.word = ''

  $scope.hideWord = () ->
    $scope.hiddenWord = $scope.word.split('')
    $scope.word = ''
    console.log($scope.hiddenWord)

  # $scope.$watch "guess", (newVal, oldVal) ->
  #     if newVal && newVal == $scope.hiddenWord
  #         alert "you guessed wisely: #{$scope.hiddenWord}"
  #         $scope.guess = ""

  $scope.letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "-"]

  $scope.hideButton = (letter) ->
    console.log(letter)
    console.log($scope.hiddenWord)    

  # $scope.splitWord = $scope.hiddenWord.split('') ->
  #   console.log(splitWord) 


]

# Define Config for CSRF token
HangmanApp.config ["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]