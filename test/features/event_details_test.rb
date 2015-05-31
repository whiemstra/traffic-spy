require_relative '../test_helper'
require 'pry'

class EventDetailsTest < Minitest::Test

  def setup
    Source.create!(identifier: 'turing', rooturl: 'http://turing.io')

    @payload_1 = 'payload={"url":"http://turing.io/team","requestedAt":"2013-02-13 21:38:28 -0700","respondedIn":37,"referredBy":"http://turing.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1200","resolutionHeight":"800","ip":"63.29.38.214"}'
    @payload_2 = 'payload={"url":"http://turing.io/team","requestedAt":"2013-02-14 21:38:28 -0700","respondedIn":88,"referredBy":"http://turing.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1200","resolutionHeight":"800","ip":"100.100.38.214"}'
    @payload_3 = 'payload={"url":"http://turing.io/admissions","requestedAt":"2013-02-14 21:38:28 -0700","respondedIn":130,"referredBy":"http://turing.com","requestType":"GET","parameters":[],"eventName": "checking_it_out","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1280","resolutionHeight":"1150","ip":"63.99.40.218"}'
    @payload_4 = 'payload={"url":"http://turing.io/admissions","requestedAt":"2013-02-14 21:38:28 -0700","respondedIn":65,"referredBy":"http://turing.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1200","resolutionHeight":"1000","ip":"52.29.38.888"}'
    @payload_5 = 'payload={"url":"http://turing.io/tuition","requestedAt":"2013-02-15 21:38:28 -0700","respondedIn":40,"referredBy":"http://turing.com","requestType":"GET","parameters":[],"eventName": "moneymoneymoney","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1300","resolutionHeight":"1100","ip":"93.92.11.245"}'
    @payload_6 = 'payload={"url":"http://turing.io/admissions","requestedAt":"2013-02-15 21:38:28 -0700","respondedIn":40,"referredBy":"http://turing.com","requestType":"GET","parameters":[],"eventName": "checking_it_out","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"120","resolutionHeight":"160","ip":"77.730.38.594"}'

    post('/sources/turing/data', @payload_1)
    post('/sources/turing/data', @payload_2)
    post('/sources/turing/data', @payload_3)
    post('/sources/turing/data', @payload_4)
    post('/sources/turing/data', @payload_5)
    post('/sources/turing/data', @payload_6)

    visit '/sources/turing/events/socialLogin'
  end

  def test_path_exists
    assert_equal '/sources/turing/events/socialLogin', current_path
  end

  def test_total_hits_are_displayed
    assert page.has_content? "Total hits: 6"
  end

  def test_breakdown_by_hour_is_displayed
    assert page.has_content? "Event hits by hour"
    assert page.has_content? "4:00: 6"
  end

  def test_it_counts_events
    visit '/sources/turing/events'
    assert page.has_content?(
        "socialLogin: 3
        checking_it_out: 2
        moneymoneymoney: 1"
      )

    refute page.has_content?(
        "checking_it_out: 2
        socialLogin: 3
        moneymoneymoney: 1"
      )
  end

  def test_it_errors_in_nonexistent_events
    visit '/sources/turing/events/divbyzero'
    assert page.has_content? "The event doesn't exist."
    assert page.has_content? "Back to Events Index"
  end

end
