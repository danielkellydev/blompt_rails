class OpenaiController < ApplicationController 
  def index
    service = OpenaiService.new(params[:query])
    @response = service.call
    render turbo_stream: turbo_stream.update('response', partial: 'response', locals: { response: @response })
  end
end