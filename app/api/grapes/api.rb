module Grapes
	class API < Grape::API 
		format format_strng :json 
		prefix :api 
		version 'v1',:path
	end
end 