class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection
  include Pundit
  protect_from_forgery

  acts_as_token_authentication_handler_for User, fallback: :none
end
