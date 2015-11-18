'use strict';
angular.module('PdfGeneratorApp')
  .controller('SignUpCtrl', function ($scope, $auth, Notification, $location) {

    $scope.signUp = function(signUpForm) {
      $auth.submitRegistration(signUpForm).then(function(){
        Notification.success("Thanks for registration.");
        $location.path("#/auth/sign_in");
      }).catch(function(resp) {
          Notification.error(resp.data.errors.full_messages.join("<br />"));
      }
    );
  }
});
