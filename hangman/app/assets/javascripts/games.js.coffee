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
  $scope.gameOver = false
  $scope.winner = false
  $scope.head = false
  $scope.torso = false
  $scope.leftHand = false
  $scope.rightHand = false
  $scope.leftFoot = false
  $scope.rightFoot = false

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

  $scope.letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "-", " "]
  $scope.hideLetter = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,false, false, false, false, false,false, false, false, false, false,false, false, false, false, false,]

  # from MDN - finds the indices for each matching element (i.e. as opposed to the first matching index)
  indicesOf = (array, element) ->
    indices =[]
    idx = array.indexOf(element)
    while idx != -1
      indices.push( idx )
      idx = array.indexOf(element, idx + 1)
    return indices

  # from stack overflow
  arrayEqual = (a, b) ->
    a.length is b.length and a.every (elem, i) -> elem is b[i]

  drawHangman = () ->
    if $scope.count == 1
      $scope.head = true
    if $scope.count == 2
      $scope.torso = true
    if $scope.count == 3
      $scope.leftHand = true
    if $scope.count == 4
      $scope.rightHand = true
    if $scope.count == 5
      $scope.leftFoot = true
    if $scope.count == 6
      $scope.rightFoot = true    

  $scope.hideButton = (letter) ->
    console.log("count", $scope.count)
    console.log(letter)
    console.log($scope.hiddenWord)
    # hide letter from keypad

    # if the game is in progress, then we check if the guess was a correct guess
    # what you really want... is
    if $scope.count < 6
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
          if arrayEqual($scope.hiddenWord, $scope.blankWord)
            console.log("You Won!")
            $scope.winner = true
      else
        $scope.count += 1
        console.log("guessed incorrectly")
        # marked as missed guess and add appendage to hangman
        drawHangman()
        if $scope.count >= 6
          console.log("Game Over!")
          $scope.gameOver = true

]

# Define Config for CSRF token
HangmanApp.config ["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]