# GitHub User Profile Viewer


A simple SwiftUI app that fetches and displays GitHub user profile information using GitHub's REST API.

## Features

- Asynchronous network call using `URLSession`
- Displays user's:
  - Avatar
  - Username
  - Bio
- Uses SwiftUI's `AsyncImage` for loading images from the web
- Basic error handling for network operations

## API Used

[GitHub REST API](https://api.github.com/users/USERNAME)
