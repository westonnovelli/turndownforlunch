class Suggestions < ActiveRecord::Base

	def vote_up
		self.vote += 1
		save
	end
end
