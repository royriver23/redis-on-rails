class PeopleController < ApplicationController

  def index
    # Access cached data or save it for the first time
    fetch_people

    # Without caching we would normally do this:
    # @people = People.all
  end

end
