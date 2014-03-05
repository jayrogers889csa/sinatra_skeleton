get '/new_user' do

  erb :'user_views/new'
end

post '/user/sign_up' do
  @user = User.new(params[:user])
  if @user.save
    session[:user_id] = @user.id
    redirect to("/homepage/#{@user.id}")
  else
    @errors = @user.errors.full_messages
    erb :'user_views/new'
  end
end

get '/user/sign_in' do
  erb :"user_views/sign_in"
end

post 'user/login' do
  @user = User.find_by_email(params[:email])

  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect to("/user/#{@user.id}")
  else
    @errors = {:Invalid=>["Name and Password do not match!"]}
    erb :"/user_views/sign_in"
  end
end

get '/user/:user_id/edit' do
  if current_user.id.to_i == params[:user_id].to_i
    erb :'user_views/edit_account'
  else
    redirect to("/")
  end
end

post '/user/:user_id/edit' do
  current_user.edit_attributes(params[:user])
  redirect "/user/#{current_user.id}"
end

get '/user/:user_id/delete' do
  if current_user.id.to_i == params[:profile_id].to_i
    erb :'user/confirm_delete'
  else
    redirect to("/")
  end
end

post '/user/:user_id/delete' do
  current_user.destroy
  session[:user_id] = nil
  redirect to("/")
end

get '/user/:user_id' do
  if current_user.id.to_i == params[:profile_id].to_i
    erb :'user_views/homepage'
  else
    redirect to("/")
  end
end
