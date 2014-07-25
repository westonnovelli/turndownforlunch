class Users < ActiveRecord::Base

	def suggestion
		self.suggestion
		logger.info "User #{:name}'s suggestion is #{self.suggestion}."
		# TODO what happens when the suggestion is nil?
	end

	def make_suggestion(suggestion)
		unless self.suggestion != nil
			self.suggestion = suggestion
			save
		end
		logger.info "User #{:name} tried to vote for more than one suggestion."
	end

	def undo_suggestion
		logger.info "User #{:name} is undoing his/her vote."
		self.suggestion = nil
		# TODO should we have some other default value, or just handle the null
		save
	end
end
