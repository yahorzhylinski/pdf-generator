'use strict';
angular
  .module('PdfGeneratorApp', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ui.router',
    'ngSanitize',
    'ngTouch',
    'ng-token-auth',
    'ui-notification'
  ])
  .config(function ($stateProvider, $urlRouterProvider) {

    $urlRouterProvider.otherwise("/reports/index");

    $stateProvider

      .state('reports', {
        url: '/reports',
        abstract: true,
        template: '<ui-view/>',
        resolve: {
          auth: function($auth, Notification, $location) {
            $auth.validateUser().catch(function(error) {
              $location.path("/auth/sign_in");
              Notification.error(error.reason.capitalize());
            });
          }
        }
      })

      .state('reports.index', {
        url: '/index',
        templateUrl: 'views/reports/index.html',
        controller: 'ReportsIndexCtrl'
      })

      .state('reports.new', {
        url: '/new',
        templateUrl: 'views/reports/new.html',
        controller: 'ReportsNewCtrl'
      })

      .state('reports.show', {
        url: '/:id',
        templateUrl: 'views/reports/show.html',
        controller: 'ReportsShowCtrl'
      })

      .state('auth', {
        url: '/auth',
        abstract: true,
        template: '<ui-view/>',
        resolve: {
          auth: function($auth, Notification, $location) {
            $auth.validateUser().then(function() {
              Notification.error("You have already signed in");
              $location.path("/reports/index");
            });
          }
        }
      })

      .state('auth.sign_in', {
        url: '/sign_in', 
        templateUrl: 'views/auth/sign_in.html',
        controller: 'SignInCtrl'
      })

      .state('auth.sign_up', {
        url: '/sign_up', 
        templateUrl: 'views/auth/sign_up.html',
        controller: 'SignUpCtrl'
      })

      .state('otherwise', {
        url: '/reports/index'
      });
  })

  .config(function($authProvider) {

    // the following shows the default values. values passed to this method
    // will extend the defaults using angular.extend

    $authProvider.configure({
      apiUrl:                  CONSTANTS.api_base_url,
      signOutUrl:              '/api/auth/sign_out',
      tokenValidationPath:     '/api/auth/validate_token',
      emailRegistrationPath:   '/api/auth',
      accountUpdatePath:       '/api/auth',
      accountDeletePath:       '/api/auth',
      confirmationSuccessUrl:  window.location.href,
      passwordResetPath:       '/api/auth/password',
      passwordUpdatePath:      '/api/auth/password',
      passwordResetSuccessUrl: window.location.href,
      emailSignInPath:         '/api/auth/sign_in',
      storage:                 'cookies',
      forceValidateToken:      false,
      validateOnPageLoad:      true,
      proxyIf:                 function() { return false; },
      proxyUrl:                '/proxy',
      omniauthWindowType:      'sameWindow',
      authProviderPaths: {
        github:   '/auth/github',
        facebook: '/auth/facebook',
        google:   '/auth/google'
      },
      tokenFormat: {
        "access-token": "{{ token }}",
        "token-type":   "Bearer",
        "client":       "{{ clientId }}",
        "expiry":       "{{ expiry }}",
        "uid":          "{{ uid }}"
      },
      parseExpiry: function(headers) {
        // convert from UTC ruby (seconds) to UTC js (milliseconds)
        return (parseInt(headers['expiry']) * 1000) || null;
      },
      handleLoginResponse: function(response) {
        return response.data;
      },
      handleAccountUpdateResponse: function(response) {
        return response.data;
      },
      handleTokenValidationResponse: function(response) {
        return response.data;
      }
    });
  });