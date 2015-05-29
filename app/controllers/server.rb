require  'digest/sha1'
require 'pry'

module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    get '/sources' do

    end

    post '/sources' do
      source = SourceValidator.new(identifier: params[:identifier], rooturl: params[:rootUrl])

      status source.validate[:status]
      body source.validate[:body]
    end

    post '/sources/:identifier/data' do |identifier|
      payload = PayloadValidator.new(params["payload"], identifier)

      status payload.validate[:status]
      body payload.validate[:body]
    end

    not_found do
      erb :error
    end
  end
end
