class StringValidator < ActiveModel::EachValidator
	def validate_each(record, attribute, value)
		passed = /^[a-zA-Z][a-zA-Z]+/ === value
		record.errors.add(attribute, "should be string") unless passed
	end
end