class Suggestions < ActiveRecord::Base

	def vote_up
		logger.info "Suggestion #{:location}: #{:depature_time} has been up voted!"
		self.vote += 1
		save
	end
end
