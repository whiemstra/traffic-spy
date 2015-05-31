require 'pry'

class EventDetails
  attr_reader :identifier, :eventname

  def initialize(identifier, eventname)
    @identifier = identifier
    @eventname = eventname
  end

  def event_exists?
    source = Source.find_by_identifier(identifier)
    source.payloads.find_by_event_name(eventname) ? true : false
  end

  def hours
    source = Source.find_by_identifier(identifier)
    source.payloads.find_by_event_name(eventname)
    event = source.payloads.select(:event_name == eventname)
    event.group_by { |payload| payload.requested_at.hour }
  end

  def receptions
    source = Source.find_by_identifier(identifier)
    source.payloads.find_by_event_name(eventname)
    event = source.payloads.select(:event_name == eventname)
    event.length
  end
end
