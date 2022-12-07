class SiteController < ApplicationController
  def index
    @title = 'Welcome'
  end

  def solutions
    @title = 'Index of solutions'
  end
end
