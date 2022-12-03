class RestaurantTablesController < ApplicationController
    before_action :set_restaurant
    before_action :set_restaurant_table, only: %i[ show edit update destroy ]

    def index
        @tables = @restaurant.restaurant_table.order(:tableno)
    end

    def create
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
            format.html { redirect_to restaurant_restaurant_tables_path(@restaurant), notice: "Table was successfully destroyed." }
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

end
