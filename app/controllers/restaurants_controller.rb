class RestaurantsController < InheritedResources::Base
  before_action :get_user
  

  def index
    @restaurants = Restaurant.where(user_id: @current_user)
    respond_to do |format|
      format.html
      format.json { render json: @restaurants }
      format.xml { render xml: @restaurants }
      end
  end

  def show 
    set_restaurant
    @menus = Menu.where(restaurant_id: params[:id])
  end

  # GET /projects/new
  def new
    @restaurant = current_user.restaurants.build
  end

  def create
    new_params = restaurant_params.merge(:user_id => @current_user)
    # puts new_params
    # puts restaurant_params
    @restaurant = current_user.restaurants.new(new_params)
    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to restaurant_url(@restaurant), notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end


  private
  
  def get_user
    @currentUser = current_user.id
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
  
  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :user_id)
  end

end
