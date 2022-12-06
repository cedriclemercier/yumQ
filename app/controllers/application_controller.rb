class ApplicationController < ActionController::Base
  helper_method :current_favorites, :my_queues, :my_seats, :set_cart

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
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create(user_id: current_user.id)
    session[:cart_id] = @cart.id
  end

end
