# JSON API for managing TODOs in Rails/Ruby

Functional Requirements:

- API should user allow to create his own projects
- User should be able to view/update/delete his own projects only
- User should be able to create tasks in any project he owns
- User should be able to update/delete tasks in his projects
- API should allow to order tasks within a project (user can change task positions inside one project - 1,2,3,4...)
- API should allow to mark user's task as 'done'
- API should allow to list user's projects
- API should allow to list tasks in user's project

# APP URL
https://thawing-coast-88544.herokuapp.com/

# ENDPOINTS

## POST /v1/users
  **When to use?**
  - create new user

  **Exemplary request payload**
  ```javascript
  {
	"user": {
		"email": "email@example.pl",
		"password": "123456A",
		"password_confirmation": "123456A"
	  }
  }
  ```

## DELETE /v1/users/{userId}
  **When to use?**
  - remove existing user

## POST /v1/sessions
  **When to use?**
  - authorize user to be able to use app
  - be possible to look over user's projects/tasks

  **Exemplary request payload**
  ```javascript
  {
	  "email": "email@example.com",
	  "password": "123456A"
  }
  ```

  **Exemplary response payload with auth data**
  ```javascript
  {
      "user": {
          "email": "email@example.com",
          "authentication_token": "EpFXa5GDk6cVzJ_NYPGJ"
      }
  }
  ```

## DELETE /v1/sessions
  **When to use?**
  - unauthorize user to not be able to use the app

## GET /v1/projects
  **When to use?**
  - see all user's projects

  **Headers**
  - X-User-Token, {authentication_token}
  - X-User-Email, {email}

## GET /v1/projects/{projectId}
  **When to use?**
  - see specific project

  **Headers**
  - X-User-Token, {authentication_token}
  - X-User-Email, {email}

## POST /v1/projects
  **When to use?**
  - create new project

  **Headers**
  - X-User-Token, {authentication_token}
  - X-User-Email, {email}

  **Exemplary request payload**
  ```javascript
  {
	  "name": "POST project"
  }
  ```

## PUT /v1/projects/{projectId}
  **When to use?**
  - modify existing project

  **Headers**
  - X-User-Token, {authentication_token}
  - X-User-Email, {email}

  **Exemplary request payload**
  ```javascript
  {
	  "name": "PUT project"
  }
  ```

## DELETE /v1/projects/{projectId}
  **When to use?**
  - remove existing project

  **Headers**
  - X-User-Token, {authentication_token}
  - X-User-Email, {email}

## GET /v1/projects/{projectId}/tasks
  **When to use?**
  - see tasks in scope of project

  **Headers**
  - X-User-Token, {authentication_token}
  - X-User-Email, {email}

## GET /v1/projects/{projectId}/tasks/{taskId}
  **When to use?**
  - see task in scope of project

  **Headers**
  - X-User-Token, {authentication_token}
  - X-User-Email, {email}

## POST /v1/projects/{projectId}/tasks
  **When to use?**
  - create task in scope of project

  **Headers**
  - X-User-Token, {authentication_token}
  - X-User-Email, {email}

  **Exemplary request payload**
  ```javascript
  {
    "name": "Task przykładowy",
    "priority": 1,
    "is_done": false
  }
  ```

## PUT /v1/projects/{projectId}/tasks{taskId}
  **When to use?**
  - modify task in scope of project

  **Headers**
  - X-User-Token, {authentication_token}
  - X-User-Email, {email}

  **Exemplary request payload**
  ```javascript
  {
	  "name": "PUT task",
	  "priority": 7,
	  "is_done": true
  }
  ```

## DELETE /v1/projects/{projectId}/tasks{taskId}
  **When to use?**
  - remove task in scope of project

  **Headers**
  - X-User-Token, {authentication_token}
  - X-User-Email, {email}
