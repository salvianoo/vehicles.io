require_relative 'environment'
require_relative 'database'
require_relative 'bugsnag'

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers',     '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'services',    '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'models',      '*.rb')].each { |file| require file }
