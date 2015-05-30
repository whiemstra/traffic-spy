require 'pry'

class ApplicationDetails < ActiveRecord::Base
  has_many :payloads
  attr_reader :identifier

  def initialize(identifier)
    @identifier = identifier
  end

  def most_to_least_requested_urls
    if identified_source = Source.find_by_identifier(identifier)
      grouped_urls = identified_source.payloads.group_by { |payload| payload[:url] }
      sorted_urls = grouped_urls.map { |url, payloads| [url, payloads.length] }
      sorted_urls.sort_by { |pair| pair[1] }.reverse
    else
      { status: 403, body: "Application Not Registered"}
    end
  end

  def screen_resolution
    if identified_source = Source.find_by_identifier(identifier)
      grouped_screen_res = identified_source.payloads.group_by { |payload| [payload[:resolution_width], payload[:resolution_height]] }
      sorted_urls = grouped_screen_res.map { |resolution, payloads| [resolution, payloads.length] }
      sorted_urls.sort_by { |pair| [pair[1], pair[0]] }
    else
      { status: 403, body: "Application Not Registered"}
    end
  end

  def sorted_response_times
    if identified_source = Source.find_by_identifier(identifier)
      urls = identified_source.payloads
      sorted_urls = urls.sort_by {|url| url[:responded_in]}.reverse
    else
      { status: 403, body: "Application Not Registered"}
    end
  end
end
