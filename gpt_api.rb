

# Authorization: Bearer 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

# test below works in terminal

https://api.openai.com/v1/chat/completions \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer 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' \
  -d '{
  "model": "gpt-3.5-turbo",
  "messages": [{"role": "user", "content": "Say this is a test!"}],
  "temperature": 0.7
}'
