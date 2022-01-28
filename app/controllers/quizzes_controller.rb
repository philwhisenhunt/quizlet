class QuizzesController < ApplicationController
  before_action :setup_quiz, only: %i[session_maker handle_answer]

  # GET /quizzes or /quizzes.json
  def index
    @quizzes = Quiz.all
    @quiz = Quiz.new
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
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@quiz, partial: 'quizzes/form', locals: { quiz: @quiz }) }
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
    @number_correct = 0
  end

  def build
    # how to account for id here? 
    @quiz = Quiz.find(params[:id])
    @question = @quiz.questions.new
  end

  def complete
    #grab users score from that round
    @score = 12 # placeholder for now
  end

  def session_maker
    # @quiz = Quiz.find(params[:id])
    # @questions = @quiz.questions.to_a
    

    unless @question.present?
      
   
      redirect_to complete_path
    end

  end

  def add_question_to_quiz
    @quiz = Quiz.find(params[:id])
    @question = @quiz.questions.new
 
  end

  def receive_question
    @question = @quiz.questions.new(questions_params)
  
    @question.answer = params[:answer]

    # And now prep for receiving a question (for POST requests)
    if @question.save
    # add in redirect
      format.html { redirect_to quiz_path(@quiz), notice: "Question was successfully created under #{@quiz.name}"}
      # format.json {render :show, status: :ok, location: @quiz}
    else
      format.html {redirect_to quiz_path(@quiz), notice: "Question was not saved." }
     
    end
  end

  def handle_answer
    # @quiz = Quiz.find(params[:id])
    @attempted_answer = params[:attempted_answer].downcase
    # @question = @quiz.questions.where(answered: false).first

    # if @question.nil?
    #   redirect_to completed_path
    # end
# byebug # what is @questions.count
    if @attempted_answer == @question.answer.downcase

      @correct_answer_count += 1
      @questions.shift
      # byebug # what is @questions.count
      session[:questions] = @questions 
      # byebug
      respond_to do |format|
        format.html { redirect_to session_maker_path(@quiz), notice: "Correct! "}
        # do we need json here
      end
      # @number_correct = @number_correct + 1
      # @right_answer = AttemptedAnswer.new(question_id: @question.id, attempted_answer: @attempted_answer)
      # @right_answer.save!
    else
      # @wrong_answer = AttemptedAnswer.new(question_id: @question.id, attempted_answer: @attempted_answer)
      # @wrong_answer.save!

      respond_to do |format|
        format.html { redirect_to session_maker_path(@quiz), notice: "Wrong!"}
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
      
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def setup_quiz
      # byebug
      # @first_value = params[:f_name]
      # session[:passed_variable] = @first_value
      
      


      @quiz ||= Quiz.find(params[:id])
     
      @questions = session[:questions]
    
      if @questions.present?  
        byebug # what format is questions?
        @question = Question.find(@questions[0]["id"])
      else
        @questions = @quiz.questions.to_a 
        @question = @questions.first
      end
      @correct_answer_count ||= 0
    end

    def set_questions
      @questions = Question.where(quiz_id: @quiz.id)
    end

    def set_number_correct
      if !@number_correct.present?
        @number_correct = 0
      end
    end

    def calculate_score
      @total_questions = @quiz.questions.count
      @percentage_correct = @number_correct / @total_questions
    end

    # Only allow a list of trusted parameters through.
    def quiz_params
      params.require(:quiz).permit(:name, :difficulty, :quiz_id)
    end

    def intro_new_quiz(questions)
      questions.each do |question|
          question.mark_as_unanswered
      end
  end
end
