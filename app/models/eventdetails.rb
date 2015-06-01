require 'pry'

class EventDetails
  attr_reader :identifier, :eventname

  def initialize(identifier, eventname)
    @identifier = identifier
    @eventname = eventname
  end

  def single_source
    Source.find_by_identifier(identifier)
  end

  def event_exists?
    single_source.payloads.find_by_event_name(eventname) ? true : false
  end

  def hours
    single_source.payloads.find_by_event_name(eventname)
    event = single_source.payloads.select(:event_name == eventname)
    event.group_by { |payload| payload.requested_at.hour }
  end

  def received_events
    single_source.payloads.find_by_event_name(eventname)
    event = single_source.payloads.select(:event_name == eventname)
    event.length
  end
end
