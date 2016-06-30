class SearchSuggestion < ActiveRecord::Base

  def self.index_people
    Person.find_each do |p|
      index_term(p.name)
      p.name.split.each {|c| index_term(c)}
    end
  end

#####################
# QUERYING DATABASE #
#####################

  # Commented out in order to use Redis BELOW!

  # def self.terms_for(prefix)
  #   where('term like ?', "#{prefix}_%").order('popularity desc').limit(10).pluck(:term)
  # end

  # def self.index_term(term)
  #   where(term: term.downcase).first_or_initialize.tap do |suggestion|
  #     suggestion.increment! :popularity
  #   end
  # end

#####################
#    USING REDIS    #
#####################

  def self.terms_for(prefix)
    $redis.zrevrange "search-suggestions:#{prefix.downcase}", 0, 9
  end
  
  def self.index_term(term)
    1.upto(term.length-1) do |n|
      prefix = term[0, n]
      $redis.zincrby "search-suggestions:#{prefix.downcase}", 1, term.downcase
    end
  end

end
