require 'pry'

class UrlStat < ActiveRecord::Base
  has_many :payloads
  belongs_to :source

  attr_reader :source,
              :full_url,
              :result

  def initialize(source, relative_path)
    @source = source
    @full_url = "#{source.rooturl}/#{relative_path}"
  end
  # binding.pry

  # def payloads_for_url
  #   source.payloads.where(url: full_url).all
  # end

  def longest_response_time
    if @source.payloads.find_by_url(full_url)
      @source.payloads.max_by { |payload| payload[:responded_in] }
      @result = { status: 200, body: "Success"}
    else
      @result = { status: 403, body: "URL Not Requested" }
    end
    @result
  end

  # def shortest_response_time
  #   payloads.min_by { |payload| payload.responded_in }
  # end
  #
  # def average_response_time
  #   payloads.reduce(0) { |total, payload| total + payload.responded_in }/payloads.length
  # end

end
