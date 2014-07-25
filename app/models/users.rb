class Users < ActiveRecord::Base

	def suggestion
		self.suggestion
		# TODO what happens when the suggestion is nil?
	end

	def make_suggestion(suggestion)
		self.suggestion = suggestion
		save
	end

	def undo_suggestion
		self.suggestion = nil
		# TODO should we have some other default value, or just handle the null
		save
	end
end
