require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Projects" do
  before do
    # user = User.create(id: 1, email: 'michaalem@o2.pl', password: '123456', password_confirmation: '123456')

    user = User.all.where(id: 1).first
    header "X-User-Token", user.authentication_token
    header "X-User-Email", user.email
  end
  
  get "/v1/projects" do
    example "GET projects endpoint" do
      do_request
      parsed_response = JSON.parse(response_body)

      expect(status).to eq 200
      expect(parsed_response).to have_key("projects")
    end
  end

  get "/v1/projects/:id" do
    byebug
    let(:project) { Project.create(name: 'TEST project') }
    let(:id) { 11 }
    example "POST project and then GET that project endpoints" do
      do_request
      parsed_response = JSON.parse(response_body)
    end
  end
  
  post "/v1/projects" do
    example "POST project endpoint" do
      request_body = { 
        "project": {
          "name": "POST project" 
        }
      }
      do_request(request_body)
      parsed_response = JSON.parse(response_body)
      expect(status).to eq 201
      expect(parsed_response).to have_key("project")
      expect(parsed_response["project"].keys).to contain_exactly("id", "name")
    end
  end
end