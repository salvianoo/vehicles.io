get '/' do
  erb :index
end

get '/users' do
  @users = User.all
  erb 'users/users'.to_sym
end

get '/users/edit/:id' do
  @user = User[id: params[:id]]
  erb 'users/edit'.to_sym
end

get '/passageiros' do
  @passageiros = Passenger.all
  erb :passageiros
end

get '/signup' do
  erb 'users/signup'.to_sym
end

post '/signup' do
  user = User.new(params)

  if user.valid?
    user.save
    SignupMessage.new(email: user.email).deliver
    session[:user_id] = user[:id]

    flash[:notice] = 'Thanks for signing up!'
    redirect '/'
  else
    flash[:errors] = user.errors
    redirect 'users/signup'
  end
end

get '/login' do
  erb 'users/login'.to_sym
end

post '/login' do
  user = User[email: params[:email]]
  password = params[:password]

  if user && user.authenticate(password)
    session[:user_id] = user[:id]

    flash[:notice] = 'Usuario logado'
    redirect '/'
  else
    flash[:errors] = 'Email or password is invalid'
    redirect '/login'
  end
end

get '/vehicle_request' do
  require_logged_in
  erb :'vehicle_requests/new'
end

post '/vehicle_request' do
  request = VehicleRequest.new(params)
  request.create_nested_passengers

  if request.valid?
    request.save
    RequestNotification.new(request: request, intercept_emails: true)
    .deliver

    flash[:notice] = 'Requisicao enviada para processo de analise'
    redirect '/'
  else
    flash[:errors] = request.errors
    redirect '/vehicle_request'
  end
end

get '/vehicle_request/edit/:id' do
  required_admin
  request = VehicleRequest[id: params[:id]]

  erb "vehicle_requests/edit".to_sym, locals: request
end

post '/vehicle_request/update/:id' do
  request = VehicleRequest[id: params[:id]]

  request.update_attributes(params)
  request.update_nested_passengers(params[:passageiros])

  if request.valid?
    request.save

    # user = User[id: session[:user_id]]
    # association user -> vehiclerequest
    # request.user.email

    # UserNotification.new(email: user.email).deliver

    # Gera pdf e envia email para o usuário imprimir requisicao

    flash[:notice] = 'Email enviado para o usuario imprimir a requisicao de veiculo'
    redirect '/'
  else
    flash[:errors] = request.errors
    redirect "/vehicle_requests/edit/#{request.id}"
  end
end

get '/logout' do
  session.clear
end

get '/admins' do
  @admins = Admin.all
  erb 'admins/admins'.to_sym
end

get '/admin/signup' do
  erb 'admins/signup'.to_sym
end

post '/admin/signup' do
  admin = Admin.new(params)

  if admin.valid?
    admin.save
    session[:admin_id] = admin[:id]

    flash[:notice] = 'Created a new admin'
    redirect '/'
  else
    flash[:errors] = admin.errors
    redirect '/admins/admin'
  end
end

get '/admin/login' do
  erb 'admins/login'.to_sym
end

post '/admin/login' do
  admin = Admin[email: params[:email]]
  password = params[:password]

  if admin && admin.authenticate(password)
    session[:admin_id] = admin[:id]

    flash[:notice] = 'Conta de admin logado'
    redirect '/'
  else
    flash[:errors] = 'Email or password is invalid'
    redirect '/login'
  end
end
