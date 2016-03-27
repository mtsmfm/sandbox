require 'bundler/setup'
Bundler.require

require 'timeout'

module CaptureCurrentRequest
  def request(params={}, &block)
    Thread.current[:excon_current_request_params] = params
    super
  end
end

Excon::Connection.prepend(CaptureCurrentRequest)

begin
  Timeout.timeout(0.01) do
    MWS.products.get_service_status
  end
rescue Timeout::Error
  puts "Timeout"
  p Thread.current[:excon_current_request_params]
end
