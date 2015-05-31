require_relative '../test_helper'
require 'pry'

class SourceRegistrationTest < Minitest::Test

  def test_valid_registration_with_identifier_and_rooturl
    initial_count = SourceValidator.count

    post('/sources', { identifier: "anIdentifier", rootUrl: "some/root/url" })

    end_count = SourceValidator.count

    assert_equal 200, last_response.status
    assert_equal "{'identifier':'anIdentifier'}", last_response.body
    assert_equal 1, (end_count - initial_count)
  end


  def test_invalid_registration_with_no_identifier
    initial_count = Source.count

    post('/sources', { rootUrl: "some/root/url" } )

    end_count = Source.count

    assert_equal 400, last_response.status
    assert_equal "Identifier can't be blank", last_response.body
    assert_equal initial_count, end_count
  end

  def test_invalid_registration_with_no_rooturl
    initial_count = Source.count

    post('/sources', { identifier: "anIdentifier" } )

    end_count = Source.count

    assert_equal 400, last_response.status
    assert_equal "Rooturl can't be blank", last_response.body
    assert_equal initial_count, end_count
  end

  def test_invalid_registration_with_existent_identifier
    post('/sources', { identifier: "anIdentifier", rootUrl: "some/root/url" } )

    initial_count = Source.count

    post('/sources', { identifier: "anIdentifier", rootUrl: "some/other/url" } )

    end_count = Source.count

    assert_equal 403, last_response.status
    assert_equal "Identifier has already been taken", last_response.body
    assert_equal initial_count, end_count
  end
end
