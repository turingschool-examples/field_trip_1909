Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/airlines', to: 'airlines#index'
  get '/airlines/:id', to: 'airlines#show'

  get '/flights', to: 'flights#index'
  # get '/flights', to: 'flights#index'
  delete "flights/:flight_id/passengers/:passanger_id/remove", to: 'passengers#remove'

  get '/passengers', to: 'passengers#index'

end
