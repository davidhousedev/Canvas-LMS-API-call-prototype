#
# Sends API GET to Canvas according to provided URL
#
# Results can be accessed from api_hash variable, or by calling to_s method
#
class CallApi
	# Creates methods for reading api_hash by calling CallApi.api_hash method
	attr_reader :api_hash

	# Converts provided URL to URI format, then calls Canvas API
	def initialize(api_url)
		# Convert to URI
		uri = URI(api_url)
		# Call Canvas API
		call_api(uri)
	end

	# This function will call Canvas API and advance through any redirects
	def call_api(uri_str, limit = 10)
		# Escapes function if server redirects 10 times
		raise ArgumentError, 'too many HTTP redirects' if limit == 0

		# Calls Canvas API according to URI
		@response = Net::HTTP.get_response(uri_str)

		# Handles repsonse code (e.g. 3**, 2**)
		case @response
		# If successful, parse JSON data to ruby Hash
		when Net::HTTPSuccess then
			@api_hash = JSON.parse(@response.body)
		# If redirect, log redirect then call method again
		when Net::HTTPRedirection then
			location = @response['location']
			warn "redirected to #{location}"
			call_api(location, limit - 1)
		# Raises HTTP error
		else
			@response.value
		end
	end

	# Read api_hash Hash as string
	def to_s
		"#{@api_hash}"
	end

end
