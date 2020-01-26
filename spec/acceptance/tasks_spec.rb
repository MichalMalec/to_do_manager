require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Tasks" do
  before do
    user = User.all.where(id: 1).first
    header "X-User-Token", user.authentication_token
    header "X-User-Email", user.email
  end
  
  get "/v1/projects/:project_id/tasks" do
    let(:project_id) { project_id = create_project.id }
    example "GET tasks endpoint" do
      create_task(project_id)
      do_request
      parsed_response = JSON.parse(response_body)

      expect(status).to eq 200
      expect(parsed_response).to have_key("tasks")
      expect(parsed_response["tasks"][0].keys).to contain_exactly("id", "name", "priority", "is_done")
    end
  end

  get "/v1/projects/:project_id/tasks/:task_id" do
    context "200" do
      let(:project_id) { create_project.id }
      let(:task_id) { create_task(project_id).id }

      example "GET task endpoint with specific id" do
        do_request
        parsed_response = JSON.parse(response_body)
        expect(status).to eq 200
        expect(parsed_response).to have_key("task")
        expect(parsed_response["task"].keys).to contain_exactly("id", "name", "priority", "is_done")
      end
    end

    context "404" do
      let(:project_id) { create_project.id }
      let(:task_id) { "x" }

      example "GET task endpoint with non-existing id" do
        do_request
        parsed_response = JSON.parse(response_body)
        expect(status).to eq 404
        expect(parsed_response).to have_key("error")
      end
    end
  end
  
  post "/v1/projects/:project_id/tasks" do
    context "201" do
      let(:project_id) { create_project.id }

      example "POST task endpoint" do
        request_body = { 
          "task": {
            "name": "POST task",
            "priority": 1,
            "id_done": false
          }
        }
        do_request(request_body)
        parsed_response = JSON.parse(response_body)
        expect(status).to eq 201
        expect(parsed_response).to have_key("task")
        expect(parsed_response["task"].keys).to contain_exactly("id", "name", "priority", "is_done")
      end
    end
  end

  put "/v1/projects/:project_id/tasks/:task_id" do
    context "201" do
      let(:project_id) { create_project.id }
      let(:task_id) { create_task(project_id).id }

      example "PUT task endpoint with specific id" do
        request_body = { 
          "task": {
            "name": "PUT task",
            "priority": 1,
            "id_done": false
          }
        }
        do_request(request_body)
        parsed_response = JSON.parse(response_body)
        expect(status).to eq 201
        expect(parsed_response).to have_key("task")
        expect(parsed_response["task"].keys).to contain_exactly("id", "name", "priority", "is_done")
      end
    end

    context "404" do
      let(:project_id) { create_project.id }
      let(:task_id) { "x" }

      example "PUT task endpoint with non-exisiting id" do
        request_body = { 
          "task": {
            "name": "PUT task",
            "priority": 1,
            "id_done": false
          }
        }
        do_request(request_body)
        parsed_response = JSON.parse(response_body)
        expect(status).to eq 404
        expect(parsed_response).to have_key("error")
      end
    end
  end

  delete "/v1/projects/:project_id/tasks/:task_id" do
    context "200" do
      let(:project_id) { create_project.id }
      let(:task_id) { create_task(project_id).id }

      example "DELETE task endpoint with specific id" do
        do_request
        parsed_response = JSON.parse(response_body)
        expect(status).to eq 200
        expect(parsed_response.keys).to contain_exactly("status", "message")
      end
    end

    context "404" do
      let(:project_id) { create_project.id }
      let(:task_id) { "0" }

      example "DELETE task endpoint with non-exisiting id" do
        do_request
        parsed_response = JSON.parse(response_body)
        expect(status).to eq 404
        expect(parsed_response).to have_key("error")
      end
    end
  end

  private 

  def create_project
    project = Project.create!(user_id: 1, name: "TEST project")
  end

  def create_task(project_id)
    task = Task.create!(project_id: project_id, name: "TEST task", is_done: false, priority: 1)
  end
end