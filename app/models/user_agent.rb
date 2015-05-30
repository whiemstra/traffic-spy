require 'pry'

class Agent < ActiveRecord::Base
  has_many :payloads
  attr_reader :identifier

  def initialize(identifier)
    @identifier = identifier
  end

  def incoming_browsers
    if identified_source = Source.find_by_identifier(identifier)
      parsed_agents = identified_source.payloads.map { |payload| UserAgent.parse(payload[:user_agent]) }
      grouped_browsers = parsed_agents.group_by { |agent| agent.browser }
      sorted_browsers = grouped_browsers.map { |browser, payloads| [browser, payloads.length] }
      descending_browsers = sorted_browsers.sort_by { |pair| pair[1] }
    else
      { status: 403, body: "Application Not Registered" }
    end
  end

  def incoming_platforms
    if identified_source = Source.find_by_identifier(identifier)
      parsed_agents = identified_source.payloads.map { |payload| UserAgent.parse(payload[:user_agent]) }
      grouped_platforms = parsed_agents.group_by { |agent| agent.platform }
      sorted_platforms = grouped_platforms.map { |platform, payloads| [platform, payloads.length] }
      descending_platforms = sorted_platforms.sort_by { |pair| pair[1] }
    else
      { status: 403, body: "Application Not Registered" }
    end
  end

  def popular_user_agent_browsers
    if identified_source = Source.find_by_identifier(identifier)
      parsed_agents = identified_source.payloads.map { |payload| UserAgent.parse(payload[:user_agent]) }
      grouped_browsers = parsed_agents.group_by { |agent| agent.browser }
      sorted_browsers = grouped_browsers.map { |browser, payloads| [browser, payloads.length] }
      descending_browsers = sorted_browsers.sort_by { |pair| pair[1] }
    else
      { status: 403, body: "Application Not Registered" }
    end
  end

  def popular_user_agent_platforms
    if identified_source = Source.find_by_identifier(identifier)
      parsed_agents = identified_source.payloads.map { |payload| UserAgent.parse(payload[:user_agent]) }
      grouped_platforms = parsed_agents.group_by { |agent| agent.platform }
      sorted_platforms = grouped_platforms.map { |platform, payloads| [platform, payloads.length] }
      descending_platforms = sorted_platforms.sort_by { |pair| pair[1] }
    else
      { status: 403, body: "Application Not Registered" }
    end

  end
end
