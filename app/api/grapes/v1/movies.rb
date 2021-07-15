module Grapes
	module V1
		class Movies < Grapes::API
		    resources :movies do
		    	desc 'Return all User'
		    	get do 
		    		Movie.all
		    	end 

		    	desc "Return spicific movie"
		    	route_param :id, type: Integer do 
		    		get do 
		    			error!('Record Not Found',404)
		    		end 
		    	end 

            end
		end
	end 
end 
