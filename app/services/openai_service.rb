class OpenaiService 
  include HTTParty
  attr_reader :api_url, :options, :query 

  def initialize(title, audience, outline, query, button)
    @title = title 
    @audience = audience
    @outline = outline 
    @query = query 
    @button = button 
    @api_url = 'https://api.openai.com/v1/chat/completions'
    @options = {
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "#{Rails.application.credentials.openai_api_key}"
      }
    }
  end

  def call 
    prompt = generate_prompt
    body = {
      model: 'gpt-4-1106-preview',
      messages: [{ role: 'user', content: prompt }]
    }
    response = HTTParty.post(api_url, body: body.to_json, headers: options[:headers], timeout: 500)
    raise response['error']['message'] unless response.code == 200
    response['choices'][0]['message']['content']
  end

  private 

  def generate_prompt 
    if @button == "help_me_get_started"
      "Given that your title is '#{@title}', your audience is '#{@audience}', and your outline is '#{@outline}', here are some suggestions to get you started:"
    elsif @button == "analyse"
      # Generate a prompt to analyse the user's writing
      "Given that your title is '#{@title}', your audience is '#{@audience}', your outline is '#{@outline}', and you've written '#{@query}', here's an analysis of your writing:"
    end
  end
end