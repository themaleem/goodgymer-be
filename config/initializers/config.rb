# frozen_string_literal: true

# @note this is needed for devise_token_auth confirmable
# @todo consider removing since i don't worry about email confirmation
def app_origin_url(append_str = '/')
  str = if Rails.env.development?
          'https://localhost:3000'
        else
          ''
        end
  "#{str}#{append_str}"
end
