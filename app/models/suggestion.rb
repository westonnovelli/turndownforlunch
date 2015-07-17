class Suggestion < ActiveRecord::Base

	def createSuggestion
		save
	end

	def vote_up
    logger.info "Suggestion #{:location}: #{:departure_time} has been up voted!"
    self.votes += 1
    save
  end

  def vote_down
    logger.info "Suggestion #{:location}: #{:departure_time} has been down voted."
    self.votes -= 1
    self.votes = 0 if self.votes < 0
    save
  end
end
