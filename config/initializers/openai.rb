#USING STARTERS GIVEN AND USAGES DESCRIBED BY https://github.com/openai/openai-ruby

## "bundler/setup"
#begin
  ## "openai" #doing this to ensure gem but using offline to stub
#rescue LoadError

#end

##USE_AI = ENV.fetch("USE_AI", "false") == "true"

#openai = OpenAI::Client.new(
# api_key: ENV["OPENAI_API_KEY"]
#)
#class OfflineOpenAIClient
  #def chat = Chat.new

  #class Chat
  #  def completions =Completions.new
  #end

  #class Completions
  # def create(messages:,model:)
      # user_msg = (messages.is_a?(Array) && messages.first && messages.first[:content])
      #


  #  end
  #end
  #end

#chat_completion = openai.chat.completions.create(messages: [{role: "user", content: "Say this is a test"}], model: :"gpt-4o")

#puts(chat_completion)