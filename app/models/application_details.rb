require 'pry'

class ApplicationDetails
  attr_reader :identifier

  def initialize(identifier)
    @identifier = identifier
  end

  def identified_source
    Source.find_by_identifier(identifier)
  end

  def requested_urls
    grouped_urls = identified_source.payloads.group_by { |payload| payload[:url] }
    sorted_urls = grouped_urls.map { |url, payloads| [url, payloads.length] }
    sorted_urls.sort_by { |pair| pair[1] }.reverse
  end

  def screen_resolution
    grouped_screen_res = identified_source.payloads.group_by { |payload| [payload[:resolution_width], payload[:resolution_height]] }
    sorted_urls = grouped_screen_res.map { |resolution, payloads| [resolution, payloads.length] }
    sorted_urls.sort_by { |pair| [pair[1], pair[0]] }
  end

  def sorted_response_times
    payloads = identified_source.payloads.group(:url).average(:responded_in)
    payloads.sort_by {|payload| payload[1] }.reverse
  end

  def count_events
    grouped_events = identified_source.payloads.group_by { |payload| payload[:event_name] }
    sorted_events = grouped_events.map { |url, payloads| [url, payloads.length] }
    sorted_events.sort_by { |pair| pair[1] }.reverse
  end

end
