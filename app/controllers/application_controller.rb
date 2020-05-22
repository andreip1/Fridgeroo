# require './config/environment'
# require '../../config.js'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    @users = User.all

    erb :'/users/index'
  end

  get '/find_recipe' do 
    @users = User.all
    # binding.pry
    erb :'/fridge/show_current_fridge'
  end

  post "/find_recipe/:id" do 
    # binding.pry 
    item = Item.where("name LIKE ?", "%#{params["id"]}%")
    @display_item = item.first.user.fridge
    @user = item.first.user

    food = params["id"].downcase
    @this = HTTParty.get("https://api.edamam.com/search?q=#{food}&app_id=#{API_ID}&app_key=#{API_KEY}")


   
    # binding.pry 
    erb :'/api/index'
  end



end
