class ApplicationController < ActionController::Base
  helper_method :current_favorites

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
  
end
