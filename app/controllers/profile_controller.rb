class ProfileController < ApplicationController

    before_action :set_profile, only: %i[ show edit ]
    def index
      @profiles = Profile.all
      puts "=========================================="
      puts @profiles
      respond_to do |format|
        format.html
        format.json { render json: @profile }
        format.xml { render xml: @profile }
        end
    end
  
    def new
      @profile = Profile.new
    end
  
    def show
    end
  
    def edit
    end
  
    def create
      @profile = Profile.new(profile_params)
          respond_to do |format|
          if @profile.save
              format.html { redirect_to @profile, notice: 'profile was successfully created.' }
          end
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_profile
        @profile = Profile.find(params[:id])
      end
  
    def profile_params
      params.require(:Profile).permit(:name, :age, :occupation, :img, :marital, :housing, :income, :sgoal, :lgoal, :questions, :tech, :other)
    end
end
