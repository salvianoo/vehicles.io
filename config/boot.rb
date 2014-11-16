require File.expand_path('config/environment')
require File.expand_path('config/database')

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'services', '*.rb')].each { |file| require file }

Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
  require model_file
end
