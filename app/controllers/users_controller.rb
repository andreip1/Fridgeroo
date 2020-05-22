class UsersController < ApplicationController
    
  get '/signup' do 
    if Helpers.is_logged_in?(session)
        user = Helpers.current_user(session)
        redirect to "/users/#{user.id}"
    end
    erb :'/users/signup'
  end


  post '/signup' do 

    # binding.pry
    if params["password"] == params["password_confirmation"]
    @user = User.create(params)
        if @user.valid?
        session["user_id"] = @user.id
        redirect to "/users/#{@user.id}"
        else 
            params["username_error"] =  true 
            erb :'/users/signup'
        end
    else  
      params["password_error"] = true
      erb :'/users/signup'
    end
    
  end 

  get  "/users/:id" do 
    if !Helpers.current_user(session) #if there's no user logged in, they're redirected to the homepage as they need to login to see any kind of fridge
      redirect to "/"
    else
    current_user = Helpers.current_user(session)
    if User.find_by(id: params["id"]) == current_user
        @user = User.find_by(id: params["id"])
        if @user.fridge == nil 
          redirect to "/fridge/new"
        end
        erb :'/users/edit'
    else 
        @user = User.find_by(id: params["id"])
        erb :'/users/show'
    end
  end
  end 

  get "/login" do 
    if Helpers.is_logged_in?(session)
        user = Helpers.current_user(session)
        redirect to "/users/#{user.id}"
    end
    erb :'/users/login'
  end

  post "/login" do 
    user = User.find_by(username: params["username"])
    if user && user.authenticate(params["password"])
        session["user_id"] = user.id
        redirect to "/users/#{user.id}"
    else 
        params["error"] = true 
        erb :'/users/login'
    end
  end

  get "/logout" do 
    session.destroy
    erb :welcome
  end

  get "/delete_account" do 
    user = Helpers.current_user(session)
    user.destroy
    session.destroy
    redirect to "/"
  end

  get "/delete_item" do 
    binding.pry
  end
end


