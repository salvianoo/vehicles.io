helpers do
  def required_admin
    redirect('/admin/login') unless admin_authenticated?
  end

  def admin_authenticated?
    !!session[:admin_id]
  end
end
