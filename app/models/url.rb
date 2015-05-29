require 'pry'

class Url < ActiveRecord::Base
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
end
