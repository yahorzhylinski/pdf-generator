Rails.application.routes.draw do

  scope :api do
    
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {registrations: "registrations", sessions: "sessions"}

    resources :reports, only: [:index, :show, :create, :update], controller: "reports"

    get '/reports/get_report_file/:id' => 'reports#get_report_file'
  end
end
