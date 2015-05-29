class Payload < ActiveRecord::Base
  belongs_to :source
  validates :payhash, presence: true, uniqueness: true

  def parse_payload!(payload_hash)
    self.url = payload_hash["url"]
    self.requested_at = DateTime.parse(payload_hash["requestedAt"]).utc # FYI - ActiveRecord all values in DB stored in UTC
    self.responded_in = payload_hash["respondedIn"]
    self.referred_by = payload_hash["referredBy"]
    self.request_type = payload_hash["requestType"]
    self.event_name = payload_hash["eventName"]
    self.user_agent = payload_hash["userAgent"]
    self.resolution_width = payload_hash["resolutionWidth"]
    self.resolution_height = payload_hash["resolutionHeight"]
    self.ip = payload_hash["ip"]
  end
end

