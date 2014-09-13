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
    $scope.hiddenWord = $scope.word.toUpperCase().split('')
    $scope.word = ''
    console.log($scope.hiddenWord)

    $scope.blankWord = []
    for letter in $scope.hiddenWord
      $scope.blankWord.push("_")

  # $scope.$watch "guess", (newVal, oldVal) ->
  #     if newVal && newVal == $scope.hiddenWord
  #         alert "you guessed wisely: #{$scope.hiddenWord}"
  #         $scope.guess = ""

  $scope.letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "-"]
  $scope.hideLetter = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,false, false, false, false, false,false, false, false, false, false,false, false, false, false, false,]

  $scope.hideButton = (letter) ->
    console.log(letter)
    console.log($scope.hiddenWord)
    # hide letter from keypad
    index = $scope.letters.indexOf(letter)
    $scope.hideLetter[index] = true

    if letter in $scope.hiddenWord
      console.log("found a letter")
      # unhide letter from $scope.hiddenWord
      # if letter in hiddenWord
      # then assign blankWord[index] to letter
      # index = array.indexOf(2)
      idxLetter = $scope.hiddenWord.indexOf(letter)
      $scope.blankWord[idxLetter] = letter 
    else
      console.log("guessed incorrectly")
      # marked as missed guess and add appendage to hangman









  # $scope.splitWord = $scope.hiddenWord.split('') ->
  #   console.log(splitWord) 


]

# Define Config for CSRF token
HangmanApp.config ["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]