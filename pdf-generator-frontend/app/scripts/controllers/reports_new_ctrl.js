'use strict';
angular.module('PdfGeneratorApp')
  .controller('ReportsNewCtrl', function ($scope, Report, Notification) {

    $scope.createReport = function(createForm) {
      
      Report.save(createForm, function(data) {
        Notification.success("The Report was created");
      }, function(data) {
        Notification.error(data.data.data.errors.join("<br />"));
      });
    }
  }
);