Rails.application.routes.draw do
  resources :quizzes
  resources :questions
  get 'home/index'
  root :to => "home#index"
  post "questions/:id", to: "questions#check_answer"
  get 'quizzes/start', to: "quizzes#start", as: "start"
  get 'reset', to: "quizzes#reset"
  get "quizzes/:id/build", to: "quizzes#build", as: "build_quiz"
  get "complete", to: "quizzes#complete"
end
