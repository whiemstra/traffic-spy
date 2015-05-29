require  'digest/sha1'
require 'pry'
require_relative '../models/url'

module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    get '/sources' do
      erb :sources
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
      source = Source.find_by_identifier(identifier)
      url = ApplicationDetails.new(identifier)
      @sorted_urls = url.requested_urls
      erb :appdetails
    end

    # get '/sources/:identifier/url/(:relative_path)' do |identifier, relative_path|   #dynamic route segments (article/1)
    #   source = Source.find_by_identifier(identifier)
    #   full_url = "#{source.rooturl}/#{relative_path}"
    #   payloads_for_url = source.payloads.where(url: full_url).all
    #
    #   # payloads_for_url are all the payloads matching the URL.
    # end
    #
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

