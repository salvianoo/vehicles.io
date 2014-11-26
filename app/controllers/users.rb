get '/' do
  erb :index
end

get '/users' do
  @users = User.all
  erb :users
end

get "/users/edit/:id" do
  @user = User[id: params[:id]]
  erb :edit
end

get '/passageiros' do
  @passageiros = Passenger.all
  erb :passageiros
end

get '/admins' do
  @admins = Admin.all
  erb :admins
end

get '/signup' do
  erb :signup
end

post '/signup' do
  user = User.new(params)

  if user.valid?
    user.save
    SignupMessage.new(email: user.get_email).deliver
    session[:user_id] = user[:id]

    flash[:notice] = "Thanks for signing up!"
    redirect '/'
  else
    flash[:errors] = user.errors
    erb :signup, locals: {errors: user.errors}
  end
end

get '/login' do
  erb :login
end

post '/login' do
  user = User[email: params[:email]]
  password = params[:password]

  if user && user.authenticate(password)
    session[:user_id] = user[:id]

    flash[:notice] = "User logged"
    redirect '/vehicle_request'
  else
    flash[:errors] = "Email or password is invalid"
    erb :login, locals: {errors: "Email / password is invalid"}
  end
end

get '/vehicle_request' do
  # puts session[:user_id]
  require_logged_in
  erb :"vehicle_requests/new"
end

post '/vehicle_request' do
  request = VehicleRequest.new(params)
  request.create_nested_passengers

  if request.valid?
    request.save
    RequestNotification.new(request: request, intercept_emails: true)
    .deliver

    flash[:notice] = "Requisicao enviada para processo de analise"
    redirect '/'
  else
    flash[:errors] = request.errors
    erb :"vehicle_requests/new", locals: {errors: request.errors}
  end
end

get '/logout' do
  session.clear
end

get '/admin' do
  erb :admin
end

post '/admin' do
  admin = Admin.new(params)

  if admin.valid?
    admin.save
    session[:admin_id] = admin[:id]

    flash[:notice] = "Created a new admin"
    redirect '/'
  else
    erb :admin, locals: {errors: admin.errors}
  end
end
