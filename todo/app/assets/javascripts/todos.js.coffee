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

  $scope.addTask = ->
    $scope.newTask.task_complete = false
    $scope.newTask.user_id = 1
    $http.post("/todos.json", $scope.newTask).success (data) ->
      #cleared the form
      $scope.newTask = {}
      #add this book to my books array      
      $scope.tasks.push(data)

  $scope.getTasks = ->
    console.log("this is happening")
    $http.get("/todos.json").success (data) ->
      console.log("this is also happening")
      $scope.tasks = data

  $scope.getTasks()

  $scope.markTaskComplete = (task) ->
    # modify the task namely set the completed field to true
    task.task_complete = true
    # send a HTTP post to the correct route so that the rails controller can update the database
    console.log(this.task.id)
    $http.put("/todos/#{this.task.id}.json", task).success (data) ->
      console.log(data)

  $scope.deleteTask = (task) ->
    conf = confirm("Are you sure?")
    if conf 
      $http.delete("/todos/#{this.task.id}.json").success (data) ->
        $scope.tasks.splice($scope.tasks.indexOf(task),1)

    # removes a task on the client-side only
    # $scope.tasks.splice($scope.tasks.indexOf(task), 1)

]


# Define Config for CSRF token
TodoApp.config ["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]