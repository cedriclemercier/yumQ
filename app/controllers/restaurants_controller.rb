class RestaurantsController < InheritedResources::Base
  before_action :get_user
  before_action :set_restaurant, only: %i[ show edit update destroy ]

  def index
    @restaurants = Restaurant.where(user_id: @current_user)
    respond_to do |format|
      format.html
      format.json { render json: @restaurants }
      format.xml { render xml: @restaurants }
      end
  end

  def show 
    if params[:search_name]
      @employees = User.where(email: params[:search_name])
    end

    if params[:add_new_employee]
      @employee = User.find_by_email(params[:add_new_employee])
      @new_staff = Staff.new({:user_id => @employee.id, :restaurant_id => @restaurant.id})
      respond_to do |format|
        if @new_staff.save
          format.html { redirect_to restaurant_url(@restaurant), notice: "Staff was successfully added." }
          format.json { render :show, status: :created, location: @restaurant }
        else
          format.html { render :show, status: :unprocessable_entity }
          format.json { render json: @restaurant.errors, status: :unprocessable_entity }
        end
      end
    end

    if params[:remove_employee]
      user = User.find_by_email(params[:remove_employee])
      @restaurant.staffs.find_by_user_id(user).delete
    end



    @menus = Menu.where(restaurant_id: params[:id])
    @staff_list = @restaurant.users
    @queues = @restaurant.wait_queue
  end

  # GET /projects/new
  def new
    @restaurant = current_user.restaurants.new
  end

  def create
    @restaurant = current_user.restaurants.create(restaurant_params)
    @restaurant.user_id = current_user.id
    @restaurant.queuetime = default_wait_queue_time
    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: "Restaurant was successfully created." }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to restaurant_url(@restaurant), notice: "restaurant was successfully updated." }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit, status: :unprocessable_entity }
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
    params.require(:restaurant).permit(:name, :address, :user_id, :queuetime)
  end

end
