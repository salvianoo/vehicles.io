helpers do
  def require_logged_in
    redirect('/login') unless user_authenticated?
  end

  def user_authenticated?
    !!session[:user_id]
  end
end
