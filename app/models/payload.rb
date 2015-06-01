class Payload < ActiveRecord::Base
  belongs_to :source
  belongs_to :event
  belongs_to :url_stat

  validates :fingerprint, presence: true, uniqueness: true

  def parse_payload!(formatted_payload)
    self.url = formatted_payload["url"]
    self.requested_at = DateTime.parse(formatted_payload["requestedAt"]).utc
    self.responded_in = formatted_payload["respondedIn"]
    self.referred_by = formatted_payload["referredBy"]
    self.request_type = formatted_payload["requestType"]
    self.event_name = formatted_payload["eventName"]
    self.user_agent = formatted_payload["userAgent"]
    self.resolution_width = formatted_payload["resolutionWidth"]
    self.resolution_height = formatted_payload["resolutionHeight"]
    self.ip = formatted_payload["ip"]
  end
end
