class Constant {
  static String baseUrl = "https://jsonplaceholder.typicode.com";

  // API Endpoints
  static const String usersEndpoint = "/users";
  static const String postsEndpoint = "/posts";

  // Network timeout durations (in milliseconds)
  static const int connectTimeout = 10000; // 10 seconds
  static const int receiveTimeout = 10000; // 10 seconds

  // Shared Preferences Keys
  static const String prefUserToken = "USER_TOKEN";
  static const String prefUserId = "USER_ID";

  // Default Values
  static const int defaultUserId = 1;
}
