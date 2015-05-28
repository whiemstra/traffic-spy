class SourceValidator < Source

  def initialize(data)
    @source = Source.new(data)
  end

  def validate
    if @source.save
      result = { status: 200, body: "{'identifier':'#{@source.identifier}'}" }
    elsif @source.errors.full_messages.include?("Identifier has already been taken")
      result = { status: 403, body: @source.errors.full_messages }
    else
      result = { status: 400, body: @source.errors.full_messages }
    end
    result
  end


end
