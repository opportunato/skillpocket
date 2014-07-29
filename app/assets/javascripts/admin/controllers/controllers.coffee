angular.module("skillpocketAdmin")
.controller("adminCtrl", ['$scope', '$location', 'Workshop', 'workshopsUrl', 'workshopsUserUrl', ($scope, $location, Workshop, workshopsUrl, workshopsUserUrl) ->
  $scope.workshopsUrl = workshopsUrl
  $scope.data = {}

  $scope.getWorkshopUserLink = (id) ->
    "#{workshopsUserUrl}/#{id}"
])

.controller("pollTableCtrl", ['$scope', 'experts', ($scope, experts) ->
  $scope.data.experts = experts
])

