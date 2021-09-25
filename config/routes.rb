Rails.application.routes.draw do
  resources :quizzes
  resources :questions
  get 'home/index'
  root :to => "home#index"
  post "questions/:id", to: "questions#check_answer"
  get 'quizzes/:id/start', to: "quizzes#start", as: "start"
  get 'reset', to: "quizzes#reset"
  get "quizzes/:id/build", to: "quizzes#build", as: "build_quiz"
  get "quizzes/complete", to: "quizzes#complete"
end
