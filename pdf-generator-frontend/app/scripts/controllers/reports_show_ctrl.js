'use strict';
angular.module('PdfGeneratorApp')
  .controller('ReportsShowCtrl', function ($scope, Report, Notification, $stateParams, $window, $http) {

    Report.show({id: $stateParams.id}, function(result) {
      $scope.report = result.data;
    }, function(result) {
      Notification.error(result.data.errors.join("<br />"));
    });

    $scope.updateReport = function(createForm) {
      
      Report.update({ id: $scope.report.id, report: createForm.report }, function(data) {
        Notification.success("The Report was updated.");
      }, function(data) {
        console.log(data)
        Notification.error(data.data.data.errors.join("<br />"));
      });
    }

    $scope.openReport = function(type) {
      var currentRequest = type == 'pdf' ? Report.getReportFilePdf : Report.getReportFileJSON
      currentRequest({ id: $scope.report.id, type: type }, function(data, asd) {
        // if(type == 'pdf') {
          var fileURL = URL.createObjectURL(data.response);
          $window.open(fileURL);
        // } else {
        //   console.log(data);
        //   alert(data);
        // }
      }, function(data) {
        Notification.error(data.statusText);
      });
    }
  }
);