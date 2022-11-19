class MenusController < ApplicationController

    before_action :set_restaurant

    def index
        @menus = Menu.all
    end

    def new
        puts params
        puts "=========================="
        @menu = Menu.new
        @menu.build_restaurant

        puts @menu
    end

     # POST /projects or /projects.json
  def create
    @menu = @restaurant.menu.new(menu_params)
    respond_to do |format|
      if @menu.save
        format.html { redirect_to @restaurant, notice: 'menu was successfully created.' }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end


  private

  def menu_params
    params.require(:menu).permit(:name, :price, :photo_url)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

end
