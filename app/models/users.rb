class Users < ActiveRecord::Base


  def up_vote(suggestion)
    puts self.id
    previous_vote = Vote.where(:suggestion_id => suggestion.id, :user_id => self.id)
    return false, "You have already voted for this." unless previous_vote.empty?
    vote = Vote.new(user_id: self.id, suggestion_id: suggestion.id)
    if vote.save
      suggestion.vote_up
      return true, "Your vote has been recorded"
    else
      return false, "Internal error"
    end
  end

  # Finds and returns user if exists; makes user otherwise
	def self.findUser(firstName, lastName)
		fullName = "#{firstName} #{lastName}"
		user = find_by_name(fullName)
		if user
			user
		else
			@user = Users.new(name: fullName)
			@user.save
		  user = find_by_name(fullName)
		end
	end
end
