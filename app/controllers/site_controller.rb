class SiteController < ApplicationController
  def index
    @title = 'Welcome'
    puts '---------------------------------'
    puts session['session_id']
  end

  def solutions
    @title = 'Index of solutions'
  end
end
