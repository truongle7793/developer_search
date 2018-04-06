module Api
  module V1
    class DevelopersController < Api::BaseController
      def show
        developer = Developer.find(params[:id])
        if stale?(last_modified: developer.updated_at.utc)
          cache_options = {compress: true, expires_in: 24.hours, race_condition_ttl: 10}
          Rails.cache.fetch("#{developer.cache_key}/#{__method__}", cache_options) do
            render json: developer,
                   include: {
                     languages: {
                       only: :code
                     },
                     programming_languages: {
                       only: :name
                     }
                   },
                   except: %i[created_at updated_at],
                   status: :ok
          end
        end
      end
    end
  end
end