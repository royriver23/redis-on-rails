module ApplicationHelper

  def fetch_people
    people = $redis.get 'people'
    if people.blank?
      people = Person.all.to_json
      $redis.set('people', people)
      # Expire the cache, every 3 hours
      $redis.expire('people',3.hour.to_i)
    end
    @people = JSON.load people
  end
  
end
