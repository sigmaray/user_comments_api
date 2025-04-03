module Api
  module V1
    class Base < Grape::API
      prefix :api
      version "v1", using: :path
      format :json
      default_error_formatter :json
      content_type :json, "application/json"

      mount Users

      add_swagger_documentation info: { title: "user-comments" }
    end
  end
end
