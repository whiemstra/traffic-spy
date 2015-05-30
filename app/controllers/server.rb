require  'digest/sha1'
require 'pry'
require_relative '../models/url'

module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      source = SourceValidator.new(identifier: params[:identifier], rooturl: params[:rootUrl])

      status source.validate[:status]
      body source.validate[:body]
    end

    post '/sources/:identifier/data' do |identifier|
      payload = PayloadValidator.new(params["payload"], identifier)

      payload.validate

      status payload.result[:status]
      body payload.result[:body]
    end

    get '/sources/:identifier' do |identifier|
      Source.find_by_identifier(identifier)

      url = ApplicationDetails.new(identifier)
      agent = Agent.new(identifier)

      @sorted_screen_res = url.screen_resolution

      @sorted_urls = url.requested_urls
      @sorted_response_times = url.sorted_response_times
      @sorted_browsers = agent.incoming_browsers
      @sorted_platforms = agent.incoming_platforms

      if Source.find_by_identifier(identifier)
        erb :appdetails
      else
        @error_message = "Application Not Registered"
        erb :error
      end

    end

    get '/sources/:identifier/events' do |identifier|
      Source.find_by_identifier(identifier)
      events = Event.new(identifier)

      events.validate

      status events.result[:status]
      body events.result[:body]
    end


    get '/sources/:identifier/urls/*' do |identifier, splat|   #dynamic route segments (article/1)
      source = Source.find_by_identifier(identifier)
      url = UrlStat.new(source, splat)
      agent = Agent.new(identifier)


      if url.verify_path_exists?
        @longest_resp_time = url.longest_response_time
        @shortest_resp_time = url.shortest_response_time
        @average_resp_time = url.average_response_time

        @payload_request_types = url.request_types

        @referrers = url.popular_referrers
        @user_agent_browsers = agent.popular_user_agent_browsers
        @user_agent_platforms = agent.popular_user_agent_platforms

        erb :relative_url_path
      else
        url.show_error
        @error_message = "Relative URL Does Not Exist"
        erb :error
      end

    end


    # get '/sources/:identifier/events/:eventname' do |identifier, eventname|
    #   source = Source.find_by_identifier(identifier)
    #   payloads_for_event = source.payloads.where(event_name: eventname).all
    #
    #   # payloads_for_event are all the payloads matching the event name.
    # end

    not_found do
      erb :error
    end

  end
end
