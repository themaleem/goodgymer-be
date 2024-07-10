# GoodGymer Session Management API

## Overview

GoodGymer Session Management API is a backend service built with Ruby on Rails that provides functionality for managing sessions and user registrations for a community-driven application. The frontend is built with React and interacts with this API to display session details, allow users to register for sessions, and more.

## Features

- **User Authentication:** Uses `devise_token_auth` for user authentication.
- **Session Management:** Create, edit, delete, and view sessions.
- **Registration Management:** Users can register and unregister for sessions.
- **Permissions:** Different types of sessions have different registration requirements:
  - **CommunityMission:** Requires `TaskForce` role.
  - **SocialVisit:** Requires DBS verification.
  - **GroupRun:** Open to all users.
- **Pairing Management:** Automatically creates pairings for `SocialVisit` sessions.

## API Workflows

### User Sign Up

1. User signs up via the registration endpoint.
2. A corresponding `Goodgymer` profile is created for the user.

### Session Management

1. **Create Session:** Users with the required permissions can create sessions.
2. **Edit Session:** Only the user who created the session can edit it.
3. **Delete Session:** Only the user who created the session can delete it, and associated registrations are also deleted.
4. **View Sessions:** Users can view all sessions or filter sessions they are registered for.

### Registration Management

1. **Register for a Session:** Users can register for sessions based on their roles and verification status.
2. **Unregister from a Session:** Users can unregister from sessions they are registered for.

## Running the Project

### Prerequisites

- Ruby 3.1.2
- Rails 7.1
- PostgreSQL
- Node.js

### Setup Instructions

1. **Clone the Repository**

   ```sh
    git clone https://github.com/themaleem/goodgymer-be.git
    cd goodgymer-be
   ```

2. **Install Dependencies**

   ```sh
    bundle install
   ```

3. **Database Setup**

   ```sh
    rails db:create
    rails db:migrate
   ```

4. **Run the Rails Server**

   ```sh
    rails s
   ```

## API Endpoints

### Authentication

- **Sign Up:** `POST /auth`
- **Sign In:** `POST /auth/sign_in`
- **Sign Out:** `DELETE /auth/sign_out`

### Sessions (Authenticated routes)

- **Get All Sessions:** `GET /sessions`
- **Create Session:** `POST /sessions`
- **Update Session:** `PUT /sessions/:id`
- **Delete Session:** `DELETE /sessions/:id`

### Registrations (Authenticated routes)

- **Register for a Session:** `POST /registrations`
- **Unregister from a Session:** `DELETE /registrations`

### Pairings

- Automatically managed through session registrations for `SocialVisit`.

## Headers format for authenticated routes

Headers values are available in the requests headers from:

- **Sign Up:** `POST /auth`
- **Sign In:** `POST /auth/sign_in`

```sh
  {
    "access-token": "wwwww",
    "token-type":   "Bearer",
    "client":       "xxxxx",
    "expiry":       "yyyyy",
    "uid":          "zz@zz.com"
  }
```
