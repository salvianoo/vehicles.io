get('/') { erb :index }

get '/users' do
  @users = User.all
  erb :users
end

get '/signup' do
  erb :signup
end

get '/login' do
  erb :login
end

post '/signup' do
  new_user = User.create(params)

  if new_user.valid?
    session[:user_id] = new_user[:id]
    flash[:notice] = "Thanks for signing up!"

    redirect '/'
  else
    erb :signup, locals: {errors: new_user.errors}
  end
end

post '/login' do
  user = User[:email => params[:email]]
  password = params[:password]

  if user && user.authenticate(password)
    session[:user_id] = user[:id]

    flash[:notice] = "User logged"
    redirect '/'
  else
    flash[:notice] = "Email or password is invalid"
    erb :login, locals: {errors: "Email / password is invalid"}
  end
end
