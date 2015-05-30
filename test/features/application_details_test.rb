require_relative '../test_helper'
require 'pry'

class ApplicationDetailsTest < Minitest::Test

  def setup
    x = Source.create!(identifier: 'turing', rooturl: 'http://turing.io')

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

    # binding.pry

    visit '/sources/turing'
  end

  def test_path_exists
    assert_equal '/sources/turing', current_path
  end

  def test_it_displays_most_to_least_hits
    assert page.has_content?("http://turing.io/team")

  # def test_it_displays_browsers
  #
  # end

  # def test_it_displays_the_OS
  #
  # end
  #
  # def test_it_displays_the_screen_rez
  #
  # end
  #
  # def test_it_displays_least_to_most_response_time
  #
  # end
  #
  # def test_it_displays_events_link
  #
  # end
  #
end


# visit '/tasks/new'
# fill_in('task[title]', with: "Groceries")
# fill_in('task[description]', with: "Milk, Eggs, Bread")
# click_link_or_button 'submit'
#
# assert page.has_content?("Groceries")
