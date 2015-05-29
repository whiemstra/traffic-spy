require_relative '../test_helper'

class PayloadTest < Minitest::Test

  def parsed_payload
   JSON.parse('{
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":37,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "parameters":[],
      "eventName": "socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211"
    }')
  end

  def test_incoming_payload_attributes_get_temp_assigned
    payload_hash = self.parsed_payload

    obj = Payload.new
    obj.parse_payload!(payload_hash)

    assert_equal "http://jumpstartlab.com/blog", obj.url
    assert_equal DateTime.parse("2013-02-16 21:38:28 -0700"), obj.requested_at
    assert_equal 37, obj.responded_in
    assert_equal "http://jumpstartlab.com", obj.referred_by
    assert_equal "GET", obj.request_type
    assert_equal "socialLogin", obj.event_name
    assert_equal "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", obj.user_agent
    assert_equal 1920, obj.resolution_width
    assert_equal 1280, obj.resolution_height
    assert_equal "63.29.38.211", obj.ip
  end


end
