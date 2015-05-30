require 'pry'

class Event < ActiveRecord::Base
  has_many :payloads
  attr_reader :identifier,
              :result
  
  def initialize(identifier)
    @identifier = identifier
  end

  def validate
    if Source.find_by_identifier(identifier)
      @result = { status: 200, body: "Success"}
    else
      @result = { status: 403, body: "Application Not Registered"}
    end
    @result
  end

end

