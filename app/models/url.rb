require 'pry'

class ApplicationDetails < ActiveRecord::Base
  has_many :payloads
  attr_reader :identifier

  def initialize(identifier)
    @identifier = identifier
  end

  def requested_urls
    if identified_source = Source.find_by_identifier(identifier)
      grouped_urls = identified_source.payloads.group_by { |payload| payload[:url] }
      sorted_urls = grouped_urls.map { |url, payloads| [url, payloads.length] }
      descending_urls = sorted_urls.sort_by { |pair| pair[1] }
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

  def count_events
    if identified_source = Source.find_by_identifier(identifier)
      grouped_events = identified_source.payloads.group_by { |payload| payload[:event_name] }
      sorted_events = grouped_events.map { |url, payloads| [url, payloads.length] }
      descending_events = sorted_events.sort_by { |pair| pair[1] }
    else
      { status: 403, body: "Application Not Registered"}
    end
  end

  # def ordered_most_to_least_events
  #  payloads.order('event_id').map { |load| load.event.event_name }.uniq
  # end
  #
  # def events_by_hour(event_id)
  #  payloads.where(event_id: event_id).map do |load|
  #    Time.parse(load.requested_at).strftime("%l %p")
  #  end
  # end
  #
  # def count_events_by_hour(event_id)
  #  events = events_by_hour(event_id)
  #  events.map do |hour|
  #    {time: hour, count: events.count(hour)}
  #  end.uniq
  # end
  #
  # def count_events(event_id)
  #  payloads.where(event_id: event_id).count
  # end
end
