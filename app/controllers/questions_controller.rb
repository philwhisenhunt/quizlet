class QuestionsController < ApplicationController
  before_action :set_question, only: %i[ show edit update destroy check_answer]
  before_action :set_up_first_and_next_question, only: %i[show check_answer beginning_of_quiz]

  # GET /questions or /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1 or /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions or /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to questions_path, notice: "Question was successfully created." }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1 or /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: "Question was successfully updated." }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1 or /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: "Question was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def check_answer
    attempt = params[:question][:attempt]
    correct_answer = @display_question.correct_answer
    attempted_answer = AttemptedAnswer.new(attempted_answer: attempt)
    # byebug
    if @display_question.check_answer(attempt) == true
      # byebug 
      attempted_answer.correct_answer = true
      @display_question.mark_as_answered
      respond_to do |format|
        if @queued_question 
    
          format.html { redirect_to start_path, notice: "Correct!" }
          format.json { head :no_content }
          # byebug
        else
          # byebug #redirect to end of path
          
          format.html { redirect_to complete_path, notice: "Correct!" }
          format.json { head :no_content }
        end
      end
    else
      attempted_answer.correct_answer = false
      respond_to do |format|
        format.html { redirect_to start_path, notice: "Question was answered incorrectly." }
        format.json { head :no_content }
      end
    end
    attempted_answer.save
  end

  def end_of_quiz
  end

  def beginning_of_quiz
  end

  def reset
    @questions = Question.all
    @questions.each do |question| 
      question.mark_as_unanswered
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    def set_up_first_and_next_question
      @display_question = Question.where(answered: false).first
      @queued_question = Question.where(answered: false).second
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:title, :answer, :attempt)
    end
end
