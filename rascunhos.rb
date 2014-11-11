# configure :production do
#   # Configure stuff here you'll want to
#   # # only be run at Heroku at boot
#   # # TIP: You can get you database information
#   # # from ENV['DATABASE_URI'] (see /env route below)
#   # end
# end

# helpers do
#   def login?
#     true if session[:user_id]
#   end
# end

# def self.create(user_params)
#   user_obj = self.new

#   user_obj.email = user_params[:email]

#   user_obj.password_salt = Engine.generate_salt
#   user_obj.password_hash = Engine.hash_secret(user_params[:password],
#                                               user_obj.password_salt)

#   user_obj
# end

# set :app_file, __FILE__

# require_relative "config/database"
# require_relative "app/models/cidade"
# require_relative "app/models/estado"

# TODO LIST
# Envio de email com Pony + Sendgrid
