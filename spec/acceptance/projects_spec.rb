require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Projects" do
  before do
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
    context "200" do
      let(:id) { id_of_created_project }

      example "GET project endpoint with specific id" do
        do_request
        parsed_response = JSON.parse(response_body)
        expect(status).to eq 200
        expect(parsed_response).to have_key("project")
        expect(parsed_response["project"].keys).to contain_exactly("id", "name")
      end
    end

    context "404" do
      let(:id) { "a" }

      example "GET project endpoint with non-existing id" do
        do_request
        parsed_response = JSON.parse(response_body)
        expect(status).to eq 404
        expect(parsed_response).to have_key("error")
      end
    end
  end
  
  post "/v1/projects" do
    context "201" do
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

  put "/v1/projects/:id" do
    context "201" do
      let(:id) { id_of_created_project }

      example "PUT project endpoint with specific id" do
        request_body = { 
          "project": {
            "name": "PUT project" 
          }
        }
        do_request(request_body)
        parsed_response = JSON.parse(response_body)
        expect(status).to eq 201
        expect(parsed_response).to have_key("project")
        expect(parsed_response["project"].keys).to contain_exactly("id", "name")
      end
    end

    context "404" do
      let(:id) { "a" }

      example "PUT project endpoint with non-exisiting id" do
        request_body = { 
          "project": {
            "name": "PUT project" 
          }
        }
        do_request(request_body)
        parsed_response = JSON.parse(response_body)
        expect(status).to eq 404
        expect(parsed_response).to have_key("error")
      end
    end
  end

  delete "/v1/projects/:id" do
    context "200" do
      let(:id) { id_of_created_project }

      example "DELETE project endpoint with specific id" do
        do_request
        parsed_response = JSON.parse(response_body)
        expect(status).to eq 200
        expect(parsed_response.keys).to contain_exactly("status", "message")
      end
    end

    context "404" do
      let(:id) { "a" }

      example "DELETE project endpoint with non-exisiting id" do
        do_request
        parsed_response = JSON.parse(response_body)
        expect(status).to eq 404
        expect(parsed_response).to have_key("error")
        byebug
      end
    end
  end

  private 

  def id_of_created_project
    project = Project.create!(user_id: 1, name: "TEST")
    project_id = project.id
  end
end