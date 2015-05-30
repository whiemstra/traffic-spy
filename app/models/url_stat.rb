require 'pry'

class UrlStat < ActiveRecord::Base
  has_many :payloads
  belongs_to :source

  attr_reader :source,
              :full_url,
              :result,
              :payloads

  def initialize(source, relative_path)
    @source = source
    @full_url = "#{source.rooturl}/#{relative_path}"
  end

  def verify_path_exists?
    if @source.payloads.find_by_url(full_url)
      true
    else
      false
    end
  end

  def show_error
    {status: 403, body: "URL Not Requested"}
  end

  # def payloads_for_url
  #   source.payloads.where(url: full_url).all
  # end

  def longest_response_time
    if @source.payloads.find_by_url(full_url)
      @source.payloads.maximum(:responded_in)
    # else
    #   0
    end
  end

  def shortest_response_time
    if @source.payloads.find_by_url(full_url)
      @source.payloads.minimum(:responded_in)
    end
  end

  def average_response_time
    if @source.payloads.find_by_url(full_url)
      @source.payloads.average(:responded_in)
    end
  end

  def request_types
    if @source.payloads.find_by_url(full_url)
      grouped_request_types = @source.payloads.group_by { |payload| payload[:request_type] }
      sorted_urls = grouped_request_types.map { |request_type, payloads| [request_type, payloads.length] }
      sorted_urls.sort_by { |pair| pair[1] }.reverse
    else
      { status: 403, body: "Application Not Registered"}
    end

    # all_payloads = Url.find_by(address: webpage).payloads
    #
    # requests = all_payloads.map do |payload|
    #   Request.find(payload.request_id).request_type
    # end
    #
    # make_lines_readable(requests)
  end

  # def self.popular_referrers(webpage)
  #   referrals = Url.find_by(address: webpage).payloads.map do |payload|
  #     Referral.find(payload.referral_id).url
  #   end
  #
  #   most_popular = (referrals.group_by {|i| i}).sort.reverse.flatten.uniq.first
  # end
  #
  # def self.popular_user_agent_browser(webpage)
  #   user_agents = Url.find_by(address: webpage).payloads.map do |payload|
  #     Agent.find(payload.agent_id).browser
  #   end
  #
  #   most_popular = (user_agents.group_by {|i| i}).sort.reverse.flatten.uniq.first
  # end
  #
  # def self.popular_user_agent_platform(webpage)
  #   user_agents = Url.find_by(address: webpage).payloads.map do |payload|
  #     Agent.find(payload.agent_id).platform
  #   end
  #
  #   most_popular = (user_agents.group_by {|i| i}).sort.reverse.flatten.uniq.first
  # end

end
