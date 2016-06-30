class PeopleController < ApplicationController

  def index
    
    @people = if params[:search] 
      Person.where("name ilike ?", "%#{params[:search]}%")
    else
      Person.all
    end
    @visits = {
      global: $redis.get('visits'),
      chrome: $redis.get('visits:chrome'),
      safari: $redis.get('visits:safari'),
      others: $redis.get('visits:others')
    }
  end

end
