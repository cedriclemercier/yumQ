class RestaurantTablesController < ApplicationController
    before_action :set_restaurant, :set_title
    before_action :set_restaurant_table, only: %i[ show edit update destroy ]

    def index
        @tables = @restaurant.restaurant_table.order(:tableno)
        @free_tables = @restaurant.restaurant_table.where(occupied: false)
        @queues = @restaurant.wait_queue.order(:start_date)
    end

    def create
        puts '-'*100
        if set_table_params['set_table']
            @table_to_change = @restaurant.restaurant_table.find_by(tableno: set_table_params['set_table']['tableno'])
            @table_to_change.update(
                user_id: set_table_params[:seated_user], 
                occupied: true, release_at: DateTime.now + @restaurant.queuetime.minutes
            )
            @q = @restaurant.wait_queue.find_by_user_id(set_table_params[:seated_user]).delete
            redirect_to restaurant_restaurant_tables_path(@restaurant)
            return
        end
        # Select all tables in that restaurant and order by table no.
        tables = @restaurant.restaurant_table.pluck(:tableno)
        max_tables = tables.length
        set_table_no = max_tables + 1

        # iterate table no until max tables number the restaurant has. 
        for t in 1..max_tables do
            # if that number is not in the array of table_no...
            if !tables.include? t
                set_table_no = t
                break
            end
        end
        
        # If missing a tableno value in that range, insert a table with that table number.


        table_params = {
            "tableno" => set_table_no
        }
        @table = @restaurant.restaurant_table.new(table_params)
        respond_to do |format|
            if @table.save
                format.html { redirect_to restaurant_restaurant_tables_path(@restaurant), notice: "Table was successfully created." }
                format.json { render :index, status: :created, location: @restaurant }
            else
                puts "Error"
                format.html { render :index, status: :unprocessable_entity }
                format.json { render json: @table.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @table.delete
        respond_to do |format|
            if @table.user_id == current_user.id
            format.html { redirect_to restaurant_restaurant_tables_path(@restaurant), notice: "Table was successfully destroyed." }
            else
            format.html { redirect_to root_path, notice: "Table was successfully destroyed." }
            end
            format.json { head :no_content }
          end
    end

    # Free a table
    # def free
    #     @table.update(:user_id)
    # end

    def update
        # method to free one table
        @table.update(user_id: nil, occupied: false, release_at: nil)
        respond_to do |format|
            # If it is the owner, return to restaurant management page, if not, return to home
            if @restaurant.user_id != current_user.id
                format.html { redirect_to root_path, notice: "Table was successfully freed." }
            else
                format.html { redirect_to restaurant_restaurant_tables_path(@restaurant), notice: "Table was successfully freed." }
            end
            format.json { head :no_content }
          end
    end

    private

    def set_restaurant
        @restaurant = Restaurant.find(params[:restaurant_id])
    end

    def set_restaurant_table
        @table = @restaurant.restaurant_table.find(params[:id])
    end

    def set_table_params
        params.permit(:authenticity_token,  :seated_user, set_table: [:tableno])
    end

    def set_title
        @title = 'Tables'
        @subtitle = 'Manage tables'
      end

end
