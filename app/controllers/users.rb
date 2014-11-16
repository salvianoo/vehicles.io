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
  user = User.new(params)

  if user.valid?
    user.save
    SignupMessage.new(user.email).deliver
    session[:user_id] = user[:id]

    flash[:notice] = "Thanks for signing up!"
    redirect '/'
  else
    erb :signup, locals: {errors: user.errors}
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
