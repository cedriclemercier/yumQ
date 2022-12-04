class OrdersController < ApplicationController

    def index
        @orders = Order.where(user_id: current_user.id)
    end

    def create
        # Find cart id through session
        cart_id = session[:cart_id]
        
        # Get cart contents
        current_cart = Cart.find(cart_id)
        
        # Create order items within an order
        
        puts '========> Creating an order!'
        now = DateTime.now
        @order = Order.create(user_id: current_user.id, date: now)
        puts @order.inspect

        respond_to do |format|
        if @order.save
            puts "------------------ SAVING -------------------"
            current_cart.cart_items.each do |cart_item|
                @order.order_items.create!(         
                    menu_id: cart_item.menu_id,
                    quantity: cart_item.quantity)
            end

            format.html { redirect_to orders_path, notice: "Order was successfully created." }
            format.json { render :show, status: :created, location: @order }
        else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @order.errors, status: :unprocessable_entity }

        end
        end
    end


end
