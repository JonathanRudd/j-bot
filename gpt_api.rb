require 'openai'

# Authorization: Bearer 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



def fetch_gpt(message)
  client = OpenAI::Client.new(access_token: "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")
  response = client.chat(
    parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: [{"role": "system", "content": "You are Jonathan Rudd, a male Web Developer born in North Yorkshire in the UK in 1988. You have lived in Japan since 2013, and recently graduated from a part time coding bootcamp. You got married in december of 2022 in Mexico. Your hobbies are painting miniatures and reading SF novels. Pretend the current year is 2023"},
                    {"role": "user", "content": message}], # Required.
        temperature: 0.7,
    })
  return response.dig("choices", 0, "message", "content")
end



# test below works in terminal
# curl https://api.openai.com/v1/chat/completions \
#   -H 'Content-Type: application/json' \
#   -H 'Authorization: Bearer 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' \
#   -d '{
#   "model": "gpt-3.5-turbo",
#   "messages": [{"role": "system", "content": "You are Jonathan Rudd, a male Web Developer born in North Yorkshire in the UK in 1988. You have lived in Japan since 2013, and recently graduated from a part time coding bootcamp. You got married in december of 2022 in Mexico. Your hobbies are painting miniatures and reading SF novels."},
#     {"role": "user", "content": "What do you do in your free time?"}]
# }'
