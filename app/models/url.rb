class Url < ActiveRecord::Base
  has_many :payloads

  def requested_urls
    if identified_source = Source.find_by_identifier(identifier)
      identified_source.payloads.group_by(:url)

    else
      { status: 403, body: "Application Not Registered"}
    end
  end
end
