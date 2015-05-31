
class Source < ActiveRecord::Base
  validates :identifier, presence: true, uniqueness: { case_sensitive: false }
  validates :rooturl, presence: true

  has_many :payloads
  has_many :url_stats
end

