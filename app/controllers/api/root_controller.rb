# frozen_string_literal: true

module API
  # API root endpoint controller.
  class RootController < APIController
    def index
      render json: {}.to_json
    end
  end
end
