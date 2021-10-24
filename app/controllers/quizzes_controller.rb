class QuizzesController < ApplicationController
  before_action :set_quiz, only: %i[ show edit update destroy build start]
  before_action :set_questions, only: %i[show build start]
  # before_action :set_up_first_and_next_question, only: %i[show check_answer start]
  # GET /quizzes or /quizzes.json
  def index
    @quizzes = Quiz.all
  end

  # GET /quizzes/1 or /quizzes/1.json
  def show
    @quiz_questions = Question.all
    # @quiz_questions = @quiz.questions.all
    # byebug # are any quiz questions false?  
    if @quiz_questions.present?
      intro_new_quiz(@quiz_questions)
      @display_question = @quiz_questions.where(answered: false).first
    else
      redirect_to build_quiz_path
    end
    
  end

  # GET /quizzes/new
  def new
    @quiz = Quiz.new
  end

  # GET /quizzes/1/edit
  def edit
  #  byebug
  end

  # POST /quizzes or /quizzes.json
  def create
    @quiz = Quiz.new(quiz_params)

    respond_to do |format|
      if @quiz.save
        format.html { redirect_to quizzes_path, notice: "Quiz was successfully created." }
        format.json { render :show, status: :created, location: @quiz }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quizzes/1 or /quizzes/1.json
  def update
    respond_to do |format|
      if @quiz.update(quiz_params)
        format.html { redirect_to @quiz, notice: "Quiz was successfully updated." }
        format.json { render :show, status: :ok, location: @quiz }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzes/1 or /quizzes/1.json
  def destroy
    @quiz.destroy
    respond_to do |format|
      format.html { redirect_to quizzes_url, notice: "Quiz was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def start
  # byebug
    @questions = Question.all
    # byebug
    @display_question = @questions.where(answered: false).first
  end

  def reset
    @questions = Question.all
    @questions.each do |question| 
      question.mark_as_unanswered
    end
  end

  def build
    @quiz = Quiz.find(params[:id])
  end

  def complete
    #grab users score from that round
    @score = 12 # placeholder for now
  end

  def session_maker
    # Render a view that includes a question here
    # On next load, swap in the correct question
    # byebug
    @quiz = Quiz.find(params[:id])
    @question = @quiz.questions.where(answered: false).first

  end

  def add_question_to_quiz
    @quiz = Quiz.find(params[:id])
    @question = @quiz.questions.new

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz
   
      @quiz = Quiz.find(params[:id])      
    end

    def set_questions
      @questions = Question.where(quiz_id: @quiz.id)

    end


    # Only allow a list of trusted parameters through.
    def quiz_params
      params.require(:quiz).permit(:name, :difficulty)
    end

    def intro_new_quiz(questions)
      questions.each do |question|
          question.mark_as_unanswered
      end
  end
end
