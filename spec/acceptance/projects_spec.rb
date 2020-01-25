require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Projects" do
  before do
    # user = User.create(id: 1, email: 'michaalem@o2.pl', password: '123456', password_confirmation: '123456')

    user = User.all.where(id: 1).first
    header "X-User-Token", user.authentication_token
    header "X-User-Email", user.email
    header "Content-Type", "application/json"
  end
  
  get "/v1/projects" do
    example "GET projects endpoint" do
      do_request
      parsed_response = JSON.parse(response_body)

      expect(status).to eq 200
      expect(parsed_response).to have_key("projects")
    end
  end
end