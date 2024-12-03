# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_record_not_found
  rescue_from ActionController::RoutingError, with: :render404

  def routing_error
    respond_to do |format|
      format.json { head :bad_request, content_type: 'text/html' }
      format.html { render404 }
      format.js { head :bad_request, content_type: 'text/html' }
    end
  end

  private

  def user_not_authorized
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html do
        render403
      end
      format.js { head :forbidden, content_type: 'text/html' }
    end
  end

  def rescue_record_not_found
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html do
        render404
      end
      format.js { head :forbidden, content_type: 'text/html' }
    end
  rescue ActionController::UnknownFormat
    render404
  end

  def render404
    render(file: File.join(Rails.root, 'public/404.html'), status: 404,
           layout: false)
  end

  def render403
    render(file: File.join(Rails.root, 'public/403.html'), status: 403,
           layout: false)
  end
end
