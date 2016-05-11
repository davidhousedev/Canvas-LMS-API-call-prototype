# include ruby gems
require 'rubygems'
require 'json'
require 'net/http'

# include class files
require './call_api'
require './assignment_grade'

# include API token constant
# NOTE: Not included in Github public repo
require './api_token'

# generates hash table from JSON data obtained from Canvas API call
# AssignmentGrade usage: (api domain, course id, assignment id, user id)
#   Generates grade information for a specific student
json_string = AssignmentGrade.new('harvard-catalog-courses.instructure.com', 20, 1725, 2058)

# prints all key=>value pairs included in API call
json_string.api_hash.each {|key, value| puts "#{key} is #{value}"}

__END__