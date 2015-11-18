'use strict';
angular.module('PdfGeneratorApp')
  .controller('ReportsIndexCtrl', function ($scope, Report, Notification) {

    Report.index(function(result) {
      $scope.reports = result.data;

    }, function(result) {
      Notification.error(result.statusText);
    });
  }
);
