class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }
  rescue_from ActionController::UnknownFormat, with: :raise_not_found

  def raise_not_found
    raise ActionController::RoutingError, 'Not supported format'
  end

  rescue_from ActiveRecord::RecordNotFound do
    respond_to do |format|
      if request.format.json?
        format.json { render json: { error: 'Not found' }, status: :not_found }
      else
        format.html { render file: 'public/404.html', status: :not_found }
      end
    end
  end
end
