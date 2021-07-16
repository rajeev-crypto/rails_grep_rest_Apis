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
		    		   movies = Movie.find(params[:id])
		    		   { movie: movie }
		    		rescue ActiveRecord::RecordNotFound 
		    			error!('Record Not Found',404)
		    		end 
		    	end 

		    	desc 'Creates a movie object'
		    	params do 
		    	    requires :title, type: String, allow_blank: false 
		    		optional :url, type: String 
		    		optional :rating, type: Float
		    	end 
		    	post do 
		    		movie = Movie.create!(declared(params))
		    		{movie: movie,message: 'Movie created successfully'}
		    	end

		    	desc 'Update existing movie object' 
		    	params do 
		    		require :title, type: String, allow_blank: false 
		    		optional :url, type: String 
		    		optional :rating, type: Float 
		        end 

		        route_param :id do 
		        	put do 
		        		movie = Movie.find(params[:id])
		        		movie.update(declared(params))
		        		{ message: "Movie updated successfuly"}
		        	rescue ActiveRecord::RecordNotFound
		        		error!('Record Not Found ',404)
		        	end 
		        end

                desc 'Deletes exisiting movie object '
                route_param :id, type: Integer do 
                  delete do
                  	Movie.find(params[:id]).delete
                  	{ message: "movie deleted succesfully " }
                  rescue ActiveRecord::RecordNotFound
                    error!('Record Not Found',404)
                   end 
                end	
            end
		end
	end 
end 
