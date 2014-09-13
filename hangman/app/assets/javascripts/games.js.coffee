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
    $scope.count = 0

    $scope.blankWord = []
    for letter in $scope.hiddenWord
      $scope.blankWord.push("_")

  # $scope.$watch "guess", (newVal, oldVal) ->
  #     if newVal && newVal == $scope.hiddenWord
  #         alert "you guessed wisely: #{$scope.hiddenWord}"
  #         $scope.guess = ""

  $scope.letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "-"]
  $scope.hideLetter = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,false, false, false, false, false,false, false, false, false, false,false, false, false, false, false,]

  indicesOf = (array, element) ->
    indices =[]
    idx = array.indexOf(element)
    while idx != -1
      indices.push( idx )
      idx = array.indexOf(element, idx + 1)
    return indices

  $scope.hideButton = (letter) ->
    $scope.count += 1
    console.log("count", $scope.count)
    console.log(letter)
    console.log($scope.hiddenWord)
    # hide letter from keypad

    if $scope.count <= 6
      index = $scope.letters.indexOf(letter)
      $scope.hideLetter[index] = true      
      if letter in $scope.hiddenWord
        console.log("found a letter")
        # then assign blankWord[index] to letter
        # idxLetter = $scope.hiddenWord.indicesOf(letter)
        # get the indicesOf the matching letters
        indices = indicesOf($scope.hiddenWord, letter)
        for idxLetter in indices
          # iterate over each of the indices and update the displayed word
          # with correctly guessed letter
          console.log(idxLetter)
          $scope.blankWord[idxLetter] = letter
      else
        console.log("guessed incorrectly")
        # marked as missed guess and add appendage to hangman
    else
      console.log("Game Over!")

]

# Define Config for CSRF token
HangmanApp.config ["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]