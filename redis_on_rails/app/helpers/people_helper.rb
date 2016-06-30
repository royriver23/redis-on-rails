module PeopleHelper

  def formatted_address(person)
    [:street, :city, :state, :zip].map do |field|
      person.send field
    end.join(', ')
  end
  
end
