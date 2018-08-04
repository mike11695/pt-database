# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

require 'airbrake-ruby'

Airbrake.configure do |c|
  c.project_id = 191743
  c.project_key = '013821b98f24bd264c561f679112bc59'

end

run Rails.application
