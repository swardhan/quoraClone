class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user!


  # GET /answers
  # GET /answers.json


  # GET /answers/new

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)
    @user = current_user
    @answer.user = current_user
    @question = @answer.question
    respond_to do |format|
      if @answer.save
        format.html { redirect_to @question, notice: 'Answer was successfully created.' }
        format.json { render :show, status: :created, location: @answer }
        format.js {}
      else
        format.html { render 'questions/new' }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json

  # DELETE /answers/1
  # DELETE /answers/1.json
  def upvote
    if current_user.voted_up_on? @answer
      @answer.unvote_by current_user
      redirect_to @answer.question
    else
      @answer.upvote_by current_user
      redirect_to @answer.question
    end
  end

  def downvote
      # @answer.downvote_by current_user
      # redirect_to @answer.question
    if current_user.voted_down_on? @answer
      @answer.downvote_by current_user
      redirect_to @answer.question
    else
      @answer.downvote_by current_user
      redirect_to @answer.question
    end
  end

  def destroy
    @question = @answer.question
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to @question, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
      format.js {}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:content, :question_id)
    end
end
