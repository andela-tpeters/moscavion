class StringValidator < ActiveModel::EachValidator
	def validate_each(record, attribute, value)
		unless /^[a-zA-Z][a-zA-Z]+/ === value
		 	record.errors.add(attribute, "must be string\
												and must start in caps")
		end
	end
end