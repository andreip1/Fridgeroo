
class FridgeController < ApplicationController
    
    get '/fridge/new' do 
        @users = User.all # for displaying the users in radio
        user = Helpers.current_user(session)

        if user.fridge != nil 
            redirect "/fridge/my_fridge"
        end 
        erb :'/fridge/new'
    end

    get '/fridge/add_expiry_date' do 
        @user = Helpers.current_user(session)
        # binding.pry
        erb :'/fridge/add_expiry_date' 
    end

    patch '/fridge/add_expiry_date' do 
        @user = Helpers.current_user(session)
        params["items"].each do |item|
          found = Item.find_by(id: item["id"])
          found.expiry_date = item["date"]
          found.save
        end 
        # binding.pry
        redirect "/fridge/show_items"
    end

    get "/fridge/my_fridge" do 
        @user = Helpers.current_user(session)
        # binding.pry
        @fridge = Fridge.find_by(id: @user.fridge_id)
        if @fridge == nil 
            redirect '/' 
        end

        erb :'/fridge/show_current_fridge'
    end

    post '/fridges' do 
        @user = Helpers.current_user(session) 
        # binding.pry
        fridge = Fridge.create(name: params[:name])
        prods = params["products"].split(/,/)
        prods.each do |item|
           it = Item.create(name: item)
           it.user = @user 
           it.save
        #    binding.pry
        end
        @user.fridge = fridge
        @user.save
        # comment
# binding.pry
        redirect "/fridge/add_expiry_date"
    end

    get '/edit_account' do 
        @user = Helpers.current_user(session)    
        # binding.pry
        erb :'/users/edit'
    end

    patch '/edit_account' do 
        user = Helpers.current_user(session)
        # binding.pry 
        user.username = params["name"]
        fridge = Fridge.find_by(id: user.fridge_id)
        fridge.name = params["fridge_name"]
        # updating fridge items 
        params["items"].each do |item|
            # binding.pry
            found = Item.find_by(id: item["id"])
            found.update(name: item["name"])
            if found.invalid?
                found.delete
            end
            found.save
        end 
        # adding new items
        params["new_item"].each do |new_item| 
            # binding.pry
            it = Item.create(name: new_item["name"])
            it.user = user 
            it.save
        end
        user.save
        fridge.save
        # binding.pry
        redirect "/fridge/add_expiry_date"
    end



    get "/fridge/show_items" do 
        @user = Helpers.current_user(session)
        erb :'/fridge/show_current_fridge'
    end


end