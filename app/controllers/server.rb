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
      # identifier.insert(-2, ",\"payhash\":\"#{Digest::SHA1.hexdigest(identifier)}\”")

      yyy = Digest::SHA1.hexdigest(params[:payload])

      # x = Source.find_by_identifier(identifier)
      if x = Source.find_by_identifier(identifier) #looking for payloads that match this source
        if x.payloads.find_by_payhash(yyy)
          status 403
          body "Already Received Request"
        else
          x.payloads.create(payhash: yyy)
          status 200
        end
      else
        status 403
        "Application Not Registered"
      end
    end

    not_found do
      erb :error
    end
  end
end

