class ApplicationController < ActionController::Base
  helper_method :current_favorites, :my_queues, :my_seats

  def current_url(overwrite = {})
    url_for :only_path => false, :params => params.merge(overwrite)
  end

  def current_favorites
    session[:favorites] ||= []
  end

  def default_wait_queue_time
    @default_wait_time = 10
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def my_queues
    @my_queues = current_user.wait_queues
  end

  def my_seats
    @my_seats = current_user.restaurant_tables
  end
  
  def set_cart
    @order = Order.find(session[:order_id])
  rescue ActiveRecord::RecordNotFound
      @order = Order.create
      session[:order_id] = @order.id
  end

end
