get '/' do
  erb :index
end

get '/users' do
  @users = User.all
  erb :users
end

get '/passageiros' do
  @passageiros = Passenger.all
  erb :passageiros
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
    SignupMessage.new(email: user.email).deliver
    session[:user_id] = user[:id]

    flash[:notice] = "Thanks for signing up!"
    redirect '/'
  else
    erb :signup, locals: {errors: user.errors}
  end
end

post '/login' do
  user = User[email: params[:email]]
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

get '/vehicle_request' do
  erb :"vehicle_requests/new"
end

post '/vehicle_request' do
  request = VehicleRequest.new(params)
  request.create_nested_passengers

  if request.valid?
    request.save
    # RequestNotification.new(request).deliver

    flash[:notice] = "Requisicao enviada para processo de analise"
    redirect '/'
  else
    erb :"vehicle_requests/new", locals: {errors: request.errors}
  end
end
