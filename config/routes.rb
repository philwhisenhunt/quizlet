Rails.application.routes.draw do
 
  resources :questions
  resources :quizzes
  get 'home/index'
  root :to => "home#index"
  post "questions/:id", to: "questions#check_answer"
  get 'quizzes/:id/reset', to: "quizzes#reset", as: "reset"
  get "quizzes/:id/build", to: "quizzes#build", as: "build_quiz"
  get "quizzes/:id/complete", to: "quizzes#complete", as: "complete"
  get "quizzes/:id/session_maker", to: "quizzes#session_maker", as: "session_maker"
  get "quizzes/:id/add_question_to_quiz", to: "quizzes#add_question_to_quiz", as: "add_question_to_quiz"
  post "quizzes/:id/session_maker", to: "quizzes#handle_answer"
  get "random", to: "quizzes#pick_random_quiz"
end
