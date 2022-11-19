class WaitQueueController < ApplicationController

    before_action :set_restaurant

    def index
    end

    def show
        @current_wait_queue = WaitQueue.first()
        end_at = @current_wait_queue.end_date
        now = DateTime.now
        @minutes_left = ((end_at - now)/60).to_i
    end

    def create
        puts "========================================="
        puts "Creating new queue!"

        # If user is signed in use current logged in
        if user_signed_in?
            d = DateTime.now
            wait_queue_params = {
                "start_date" => d,
                "end_date" => d + @restaurant.queuetime.minutes,
                "restaurant_id" => 3,
                "user_id" => current_user.id,
                "status" => true}

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
        @restaurant = Restaurant.find('2')
    end

    def wait_queue_params
        params.require(:wait_queue).permit(:start_date, :end_date, :status, :restaurant_id)
    end
end
