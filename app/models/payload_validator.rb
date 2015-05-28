require 'json'

class PayloadValidator < Payload

  def initialize(data)
    @payload = Payload.new(data)
  end

  def validate
    yyy = Digest::SHA1.hexdigest(params[:payload])
    if x = Source.find_by_identifier(identifier)
      if x.payloads.find_by_payhash(yyy)
        status 403
        body "Already Received Request"
      else
        x.payloads.create(payhash: yyy)
        status 200
      end
    else
      status 403
      "Application Not Registered"
    end
  end
end
