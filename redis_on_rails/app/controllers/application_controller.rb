class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :visits_updates

  private
  def visits_updates
    $redis.incr 'visits'
    if browser.chrome?
      $redis.incr 'visits:chrome'
    elsif browser.safari?
      $redis.incr 'visits:safari'
    else
      $redis.incr 'visits:others'
    end      
  end

end
