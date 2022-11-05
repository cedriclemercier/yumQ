class UserController < ApplicationController
  before_action :set_user, only: %i[ show edit ]
  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.json { render json: @user }
      format.xml { render xml: @user }
      end
  end

  def new
    @user = User.new
  end

  def show
  end

  def edit
  end

  def create
    @user = User.new(user_params)
        respond_to do |format|
        if @user.save
            format.html { redirect_to @user, notice: 'user was successfully created.' }
        end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

  def user_params
    params.require(:user).permit(:name, :age, :occupation, :img, :marital, :housing, :income, :sgoal, :lgoal, :questions, :tech, :other)
  end
end
