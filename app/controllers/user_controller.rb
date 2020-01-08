class UserController < ApplicationController
  def index
  	user = get_random_name
  	joke = get_random_joke(user['name'],user['surname'])
  	msg = { :status => "success", :joke => joke['value']['joke']}
  	render :json => msg
  end

  def get_random_name
  	HTTParty.get('http://uinames.com/api/')
  end

  def get_random_joke(firstName, lastName)
  	params = "firstName=#{firstName}&lastName=#{lastName}&limitTo=[nerdy]"
  	url = "http://api.icndb.com/jokes/random?#{params}"
  	begin
  		response = HTTParty.get(url)
  	rescue URI::InvalidURIError
  		response = HTTParty.get(URI.escape(url))
  	end
  	response
  end
end
