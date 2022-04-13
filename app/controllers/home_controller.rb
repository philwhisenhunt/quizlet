class HomeController < ApplicationController
  
  def index
    @random_quiz = Quiz.where(include_in_random: true).sample
  end
end
