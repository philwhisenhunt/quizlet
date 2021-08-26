Rails.application.routes.draw do
  resources :quizzes
  resources :questions
  get 'home/index'
  root :to => "home#index"
  post "questions/:id", to: "questions#check_answer"
  get 'start', to: "questions#beginning_of_quiz"
  get 'reset', to: "questions#reset"
end
