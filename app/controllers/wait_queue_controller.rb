class WaitQueueController < ApplicationController

    before_action :set_restaurant, only: %i[ create edit destroy update ]
    before_action :set_current_queue, only: %i[ create ]

    def index
    end

    def show
        @current_wait_queue = WaitQueue.find_by_user_id(current_user.id)
        end_at = @current_wait_queue.end_date
        now = DateTime.now
        @minutes_left = ((end_at - now)/60).to_i
        @time_left = TimeDifference.between(end_at, now).humanize
    end

    def create
        puts '--------------------'
        puts params[:restaurant_id]
        # If user is signed in use current logged in
        if user_signed_in?

            # Check if the user is already seated in that restaurant
            # If he is seated redirect to menu
            user_seated = @restaurant.restaurant_table.where(user_id: current_user.id)
            if (user_seated.length > 0)
                redirect_to restaurant_menus_path(@restaurant)
                return
            end

            # If not seated check if he is in queue waiting
            user_waiting = @restaurant.wait_queue.where(user_id: current_user.id, status: "waiting")
            if (user_waiting.length > 0)
                redirect_to wait_queue_path(@current_queue)
                return
            end

            # if not then is the user waiting to be seated?
            user_waiting = @restaurant.wait_queue.where(user_id: current_user.id, status: "pending")
            if (user_waiting.length > 0)
                redirect_to wait_queue_path(@current_queue)
                return
            end

            # finally, if the user isnt anywhere to be found, it means he's a fresh customer!
            # check if any table is free in that restaurant
            d = DateTime.now

            @get_one_table = @restaurant.restaurant_table.where(occupied: false)
            if (@get_one_table.length > 0)
                # add user to the restaurantTable if found one
                @get_one_table.update(user_id: current_user.id, occupied: true, release_at: d + @restaurant.queuetime.minutes)
                redirect_to restaurant_menus_path(@restaurant)
                return
            end

            # else create a new queue


            wait_queue_params = {
                "start_date" => d,
                "end_date" => d + @restaurant.queuetime.minutes,
                "restaurant_id" => params[:restaurant_id],
                "user_id" => current_user.id,
                "status" => :waiting}

            @wait_queue = WaitQueue.new(wait_queue_params)

            respond_to do |format|
                if @wait_queue.save
                  format.html { redirect_to wait_queue_url(@wait_queue), notice: "Queue was successfully created." }
                  format.json { render :show, status: :created, location: @wait_queue }
                else
                  format.html { render :new, status: :unprocessable_entity }
                  format.json { render json: @wait_queue.errors, status: :unprocessable_entity }
                end
            end
        
        # If user not signed in, use current session id
        else
            puts "not signed in!"
        end

    end


    private

    # TODO. Current placeholder, in the future restaurant_id will be given by POST request through QR Code
    def set_restaurant
        @restaurant = Restaurant.find(params[:restaurant_id])
        rescue ActiveRecord::RecordNotFound => e
            # render html: {
            # error: e.to_s,
            # }, status: :not_found
            @error = e.to_s + '. Or try to create a new restaurant?'
            render action: "error", message: e.to_s and return
    end

    def wait_queue_params
        params.require(:wait_queue).permit(:start_date, :end_date, :status, :restaurant_id)
    end

    def set_current_queue
        @current_queue = @restaurant.wait_queue.find_by user_id: current_user.id
    end
end
