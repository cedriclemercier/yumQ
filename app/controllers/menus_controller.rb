class MenusController < ApplicationController
  before_action :set_restaurant
  before_action :set_menus, only: %i[ show edit update destroy]
  before_action :set_menu, only: %i[show edit update destroy]

    def index
        @menus = Menu.all
    end

    def new
        puts params
        @menu = Menu.new
        @menu.build_restaurant
        
        puts @menu
      end
      
      def edit
    end

     # POST /projects or /projects.json
  def create
    @menu = @restaurant.menus.new(menu_params)
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

  def update
    respond_to do |format|
      if @menu.update(menu_params)
        format.html { redirect_to restaurant_url(@restaurant), notice: "restaurant was successfully updated." }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @menu.delete
    respond_to do |format|
        format.html { redirect_to restaurant_path(@restaurant), notice: "Table was successfully destroyed." }
        format.json { head :no_content }
      end
end

  private

  def menu_params
    params.require(:menu).permit(:name, :price, :photo_url)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def set_menus
    @menus = @restaurant.menus.all
  end

  def set_menu
    @menu = @restaurant.menus.find(params[:id])
  end

end
