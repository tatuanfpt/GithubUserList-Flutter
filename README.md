# github_users_app

**Key Features and Notes:**

- **Architecture**: Uses `Provider` for state management, similar to MVVM. `UserListProvider` and `UserDetailProvider` manage state, akin to ViewModels.
- **Networking**: The `http` package replaces URLSession, with `ApiClient` abstracting requests for testability.
- **Storage**: `sqflite` replaces CoreData for caching users, ensuring instant display on app relaunch.
- **Pagination**: Loads 20 users per fetch, triggered when scrolling near the list bottom.
- **UI**: Simple `ListView` for the user list and a `Column` with `CachedNetworkImage` for details, mirroring the UIKit app’s functionality.
- **Tests**: Unit tests cover `GitHubService` and `UserListProvider` using `mockito` for mocking.
- **Documentation**: Inline comments explain key components, making it beginner-friendly.
- **Dependencies**:
  - `http`: For API calls.
  - `provider`: For state management.
  - `sqflite`: For local storage.
  - `cached_network_image`: For efficient image loading.
  - `json_annotation`: For JSON serialization.
- **Android**: The app is cross-platform and runs on Android without changes, but iOS is the focus per my preference.
