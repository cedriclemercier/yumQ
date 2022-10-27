class ApplicationController < ActionController::Base
  helper_method :current_favorites

  def current_url(overwrite = {})
    url_for :only_path => false, :params => params.merge(overwrite)
  end

  def current_favorites
    session[:favorites] ||= []
  end
end
