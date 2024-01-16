class OpenaiService 
  include HTTParty
  attr_reader :api_url, :options, :query 

  def initialize(query)
    @query = query 
    @api_url = 'https://api.openai.com/v1/chat/completions'
    @options = {
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "#{Rails.application.credentials.openai_api_key}"
      }
    }
  end

  def call 
    body = {
      model: 'gpt-4-1106-preview',
      messages: [{ role: 'user', content: query }]
    }
    response = HTTParty.post(api_url, body: body.to_json, headers: options[:headers], timeout: 500)
    raise response['error']['message'] unless response.code == 200
    response['choices'][0]['message']['content']
  end
end