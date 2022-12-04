class SiteController < ApplicationController
  def index
    @title = 'Welcome'
    puts '0'*100
    set_cart
    puts session[:favorites]
    puts session[:cart_id]
  end

  def solutions
    @title = 'Index of solutions'
  end
end
