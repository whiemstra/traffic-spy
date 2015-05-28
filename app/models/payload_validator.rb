require 'json'

class PayloadValidator < Payload
  attr_reader :identifier

  def initialize(data, identifier)
    @hashed = Digest::SHA1.hexdigest(data)
    JSON.parse(data)
    @payload = Payload.new(requested_at: data["requestedAt"])
    @identifier = identifier
  end

  def validate
    if identified_source = Source.find_by_identifier(identifier)
      if identified_source.payloads.find_by_payhash(@hashed)
        result = { status: 403, body: "Already Received Request" }
      else
        identified_source.payloads.create(payhash: @hashed)
        result = { status: 200, body: ""}
      end
    else
      result = { status: 403, body: "Application Not Registered"}
    end
    result
  end
end

