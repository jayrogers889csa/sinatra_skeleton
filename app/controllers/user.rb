get '/new_user' do

  erb :'user_views/new'
end

post '/user/sign_up' do
  @user = User.new(params[:user])
  if @user.save
    session[:user_id] = @user.id
    redirect to("/homepage/#{@user.id}")
  else
    @errors = @user.errors.messages
    erb :'user_views/new'
  end
end

get '/user/sign_in' do
  erb :"user_views/sign_in"
end

post '/user/login' do
  @user = User.find_by_email(params[:email])
  p @user
  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect to("/homepage/#{@user.id}")
  else
    @errors = {:Login_Fail=>["Name and Password do not match!"]}
    erb :"/user_views/sign_in"
  end
end

get '/user/sign_out' do
  session[:user_id] = nil
  redirect to("/")
end

get '/user/:user_id/edit' do
  if current_user.id.to_i == params[:user_id].to_i
    erb :'user_views/edit_account'
  else
    redirect to("/")
  end
end

post '/user/:user_id/update' do
  @user = User.find(session[:user_id])

  @user.update_attributes(params[:user])

  if @user.save
    p "See me"
    redirect to("/homepage/#{current_user.id}")
  else
    p "im here"
    @errors = @user.errors.messages
    p @errors
    erb :"/user_views/edit_account"
  end
end

get '/user/:user_id/delete' do
  if current_user.id.to_i == params[:user_id].to_i
    if request.xhr?
      erb :'user_views/confirm_delete', :layout => false
    end
  else
    redirect to("/")
  end
end

post '/user/:user_id/delete' do
  current_user.destroy
  session[:user_id] = nil
  redirect to("/")
end

get '/homepage/:user_id' do
  if current_user.id.to_i == params[:user_id].to_i
    erb :'user_views/homepage'
  else
    redirect to("/")
  end
end
