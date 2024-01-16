class OpenaiController < ApplicationController 
  def index
    button = params[:help_me_get_started] != "" ? "help_me_get_started" : "analyse"
    service = OpenaiService.new(params[:title], params[:audience], params[:outline], params[:query], button)
    @response = service.call
    render turbo_stream: turbo_stream.update('response', partial: 'response', locals: { response: @response })
  end
end