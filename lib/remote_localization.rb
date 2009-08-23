require "action_controller"

SERVICE = "http://ipinfodb.com/ip_query.php"
RESPONSE_KEY = 'Response'

class ActionController::Base
  def remote_localization(ip = nil)
    return GeoIp.config.default_return_value unless GeoIp.config.default_return_value.nil?

    remote_ip = ip || request.remote_ip
    uri = SERVICE + "?ip=#{remote_ip}"
    url = URI.parse(uri)
    Hash.from_xml(Net::HTTP.get(url))[RESPONSE_KEY]
  end
end
