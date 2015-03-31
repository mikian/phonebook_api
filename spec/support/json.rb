require 'json'
module JsonHelper
  def response_body
    JSON.parse(response.body)
  end
end

RSpec.configure do |config|
  config.include JsonHelper
end
