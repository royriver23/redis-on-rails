module PeopleHelper

  def formatted_address(person)
    %w(street city state zip).map do |field|
      person[field]
    end.join(', ')
  end
  
end
