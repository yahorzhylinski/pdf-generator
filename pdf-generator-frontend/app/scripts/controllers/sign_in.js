'use strict';
angular.module('PdfGeneratorApp')
  .controller('SignInCtrl', function ($scope, $auth, Notification, $location) {

    $scope.login = function(loginForm) {
      $auth.submitLogin(loginForm).then(function(data){
        $location.path('/reports/index');
      }).catch(function(resp) {
          Notification.error(resp.errors.join("<br />"));
        }
      );
    }
  });
