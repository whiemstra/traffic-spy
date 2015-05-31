require 'pry'

class EventDetails < ActiveRecord::Base
  has_many :payloads
  attr_reader :identifier, :eventname

  def initialize(identifier, eventname)
    @identifier = identifier
    @eventname = eventname
  end

  def hours
    if source = Source.find_by_identifier(identifier)
      if source.payloads.find_by_event_name(eventname)
        event = source.payloads.select(:event_name == eventname)
        event.group_by { |payload| payload.requested_at.hour }
      else
        { status: 403, body: "Event Not Existent" }
      end
    else
      { status: 403, body: "Application Not Registered" }
    end
  end

  def receptions
    if source = Source.find_by_identifier(identifier)
      if source.payloads.find_by_event_name(eventname)
        event = source.payloads.select(:event_name == eventname)
        event.length
      else
        { status: 403, body: "Event Not Existent" }
      end
    else
      { status: 403, body: "Application Not Registered" }
    end
  end
end
