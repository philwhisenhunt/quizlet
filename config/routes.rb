Rails.application.routes.draw do
  resources :quizzes
  resources :questions
  get 'home/index'
  root :to => "home#index"
  post "questions/:id", to: "questions#check_answer"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
