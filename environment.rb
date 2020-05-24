# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :port           => ENV['MAILGUN_SMTP_PORT'],
  :address        => ENV['MAILGUN_SMTP_SERVER'],
  :user_name      => ENV['MAILGUN_SMTP_LOGIN'],
  :password       => ENV['MAILGUN_SMTP_PASSWORD'],
  :domain         => 'pacific-crag-26799.herokuapp.com/',
  :authentication => :plain,
}
ActionMailer::Base.delivery_method = :smtp

if ENV['RAILS_ENV'] == 'production'  # don't bother on dev
  ENV['GEM_PATH'] = '/home/USERNAME/.gems' #+ ':/usr/lib/ruby/gems/1.8'  # Need this or Passenger fails to start
end

require File.join(File.dirname(__FILE__), 'boot')
