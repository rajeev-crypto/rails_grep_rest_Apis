require 'rails_helper'
RSpec.describe 'Movies', type: :request do 
	describe 'GET /movies' do
	  let!(name :movie) { create(:movie) }
	  it 'returns success code' do 
	    get '/api/v1/movies'
	    expect(response).to have_http_status(200) 
	   end 


	   it 'return all movies' do 
	   	movies  = Movie.all 
	   	get '/api/v1/movies'
	   	expect(JSON.parse(response.body)).to eq(JSON.parse(movies.to_json))
	   end 
	end  

	describe 'GET /movie/:id' do 
		let!(name :movie) { create(:movie) }
		it 'returns 404 status for an invalid id' do 
			get '/api/v1/movies/1000'
			expect(response).to have_http_status(404)
		end

		it 'return spcific movie' do 
			get "/api/v1/movies/#{movie.id}"
			expect(JSON.parse(response.body)['movie']['name']).to eq(movie.name)
	    end 
	end 

	describe 'POST /movies' do 
		let!(:params) { { title: 'some movie title' ,rating: 7, url: 'movie.com' }}

		context 'Valid params' do
		  it 'creates a new movie ' do
		    post '/api/v1/movies', params: params 
		    expect(JSON.parse(response.body)['movie']['title']).to eq('some movie title')
		  end

		  it 'returns 201 status' do 
		    post '/api/v/movies', params: params
		    expect(response.status).to eq(201)
		  end 
		end

		context 'Invalid params' do 
			it 'returns empty title error' do 
				params[:title] = ''
				post '/api/v1/movies',params: params
				puts response.body.inspect
				expect(JSON.parse(response.body)['error']).to eq('title is empty')
			end 
		end 


    end  

end 
