# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
#Institute::Application.initialize!
ActiveSupport::Deprecation.silence do
  Institute::Application.initialize!
end