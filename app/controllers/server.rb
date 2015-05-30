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

      @sorted_urls = url.requested_urls
      @sorted_response_times = url.sorted_response_times
      @sorted_browsers = agent.incoming_browsers
      @sorted_platforms = agent.incoming_platforms

      erb :appdetails
    end

    get '/sources/:identifier/events' do |identifier|
      Source.find_by_identifier(identifier)
      events = Event.new(identifier)

      events.validate

      status events.result[:status]
      body events.result[:body]
    end


    get '/sources/:identifier/urls/:relative_path' do |identifier, relative_path|   #dynamic route segments (article/1)
      source = Source.find_by_identifier(identifier)
      url = UrlStat.new(source, relative_path)


      @url_stat = url.longest_response_time

      erb :relative_url_path
      # payloads_for_url.shortest_response_time
      # payloads_for_url.average_response_time


      #payloads_for_url are all the payloads matching the URL.
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
