'use strict';
angular.module('PdfGeneratorApp')
  .factory("Report", function($resource) {

    return $resource(CONSTANTS.api_base_url + "/api/reports/:id", { id: "@id" },
      {
        'create':  { method: 'POST' },
        'index':   { method: 'GET', isArray: false },
        'show':    { method: 'GET', isArray: false },
        'update':  { method: 'PUT' },
        'getReportFilePdf': { 
          method: 'GET',
          url: CONSTANTS['api_base_url'] + "/api/reports/get_report_file/:id/.pdf",
          headers: {
              accept: 'application/pdf'
          },
          responseType: 'arraybuffer',
          cache: true,
          transformResponse: function (data) {
            var pdf;
            if (data) {
              pdf = new Blob([data], {
                type: 'application/pdf'
              });
            }
            return {
              response: pdf
            };
          }
        },              
        'getReportFileJSON': {
          method: 'GET',
          url: CONSTANTS['api_base_url'] + "/api/reports/get_report_file/:id/.json",
          isArray: false,
          headers: {
            accept: 'application/json'
          },
          cache: true,
          transformResponse: function (data) {
            var json;
            if (data) {
              json = new Blob([data], {
                type: 'application/json'
              });
            }
            return {
              response: json
            };        
          }          
        }
      });
    });