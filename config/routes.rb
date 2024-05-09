Rails.application.routes.draw do

  get '/records' => "records#index"
  post '/records/find' => "records#search"
  post '/records/new' => "records#create"

  get '/patients' => "patients#index"
  post '/patients/find' => "patients#search"
  post '/patients/new' => "patients#create"

  post '/refresh', controller: :refresh, action: :create
  post '/login', controller: :signin, action: :create
  delete '/logout', controller: :signin, action: :destroy

  post '/doctor/register' => "signup#create"

end
