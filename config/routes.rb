Rails.application.routes.draw do
  resources :quizzes
  resources :questions
  get 'home/index'
  root :to => "home#index"
  post "questions/:id", to: "questions#check_answer"
  get 'start', to: "quizzes#start"
  get 'reset', to: "quizzes#reset"
end
