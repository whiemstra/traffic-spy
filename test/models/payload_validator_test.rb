require_relative '../test_helper'

class PayloadValidatorTest < Minitest::Test

  def string_payload
    '{
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
    }'
  end

  def test_incoming_payload_attributes_get_saved_to_payloads_table
    source = Source.create!(identifier: 'foo', rooturl: 'http://foo/bar')

    assert_equal 0, Payload.count

    obj = PayloadValidator.new(string_payload, source.identifier)
    obj.validate

    assert_equal 1, Payload.count

    payload_obj = Payload.first

    assert_equal Digest::SHA1.hexdigest(string_payload), payload_obj.payhash
    assert_equal "http://jumpstartlab.com/blog", payload_obj.url
    assert_equal DateTime.parse("2013-02-16 21:38:28 -0700"), payload_obj.requested_at
    assert_equal 37, payload_obj.responded_in
    assert_equal "http://jumpstartlab.com", payload_obj.referred_by
    assert_equal "GET", payload_obj.request_type
    assert_equal "socialLogin", payload_obj.event_name
    assert_equal "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", payload_obj.user_agent
    assert_equal 1920, payload_obj.resolution_width
    assert_equal 1280, payload_obj.resolution_height
    assert_equal "63.29.38.211", payload_obj.ip
  end

end
