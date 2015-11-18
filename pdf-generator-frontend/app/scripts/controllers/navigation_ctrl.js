'use strict';
angular.module('PdfGeneratorApp')
  .controller('NavigationCtrl', function ($rootScope, Notification, $scope, $location) {

    $rootScope.$on('auth:login-success', function(ev, user) {
      Notification("Welcome, " + user.username + "!");
    });

    $rootScope.$on('auth:logout-success', function(ev, user) {
      $location.path("/auth/sign_in");
      Notification("Goodbye!");
    });
  }
);
