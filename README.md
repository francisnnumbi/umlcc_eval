# umlcc_eval

A flutter project for evaluation

## Task Description

Creating an application with the following points :

- [X]  A login mechanism
- [X]  A registration mechanism
- [X]  A verification mechanism
- [X]  A home page with a list of products [ and a product details page, if necessary]
- [X]  A me or profile page

## Endpoints

These are stated in the app's `lib/api/endpoints.dart` file. But they can also be found under each request section
above.

## Particularities of Requests

Cookie should be sent inside the header of the request. `X-DID` takes the value of `identity` and the `Authorization`
takes the value of `Bearer $token` where `$token` is the `access_token` received after a successful verify.

### Register Post Request :

End point : `https://umlcc.chd-staging.tech/api/app/auth/register`

These go in the body of the request:

`dial_code`, `first_name`, `last_name`, `identity`, `phone`, `type="individual"`

### Login Post Request :

End point : `https://umlcc.chd-staging.tech/api/app/auth/login`

These go in the body of the request:

`dial_code`, `phone`, `identity`

### Verify Post Request :

End point : `https://umlcc.chd-staging.tech/api/app/auth/verify`

these go in the body of the request:

`dial_code`, `phone`, `identity`, `code`

`code` is the verification code sent to the user's phone number, or `otp`.

`):` At this point, user should be verified and logged in order to perform the next requests.

### Me Get Request :

End point : `https://umlcc.chd-staging.tech/api/app/account/me`

These go in the header of the request:

`X-DID`, `Authorization:'Bearer $token'`, `Accept:'application/json'`

### Products Get Request :

End point : `https://umlcc.chd-staging.tech/api/app/products`

These go in the header of the request:

`X-DID`, `Authorization:'Bearer $token'`, `Accept:'application/json'`

## Points to Clarify

Terms

- [X]  The `identity` field is the device unique ID to be sent in the body of the request.
  But when this ID is sent in the headers, it is referred to as `X-DID`.
- [X]  The `dial_code` field is the country code of the user.
- [X]  The `phone` field is the phone number of the user.
- [X]  The `code` field is the verification code received in the response of register and login requests.
  When received, it is named `otp`.
- [X]  The `type` field is the type of user. It can be either `individual` or `business`.
- [X]  The `token` field is the token received after a successful verify request. When received, it is
  named `access_token`.
- [x]  The `token_type` is the type of token received after successful verify request.
  This is usually concatenated with the token when sent in the headers as `Authirization` value.
- [X]  The `X-DID` field is the device unique ID to be sent in the headers. This is the same as `identity` mentioned
  above.
- [X]  The `Accept` field is the header sent with the request stating the type of data that is expected to be received.
- [X]  The `Authorization` field is the header sent with the request. It takes as value the token received after
  successful verify request.
- [X]  The `Bearer`is the type of authorization attached as value of `Authorization` and is concatenated with
  the `token`. This is received as `token_type` in the response of the successful verify request.
- [X]  The `fcm_token` is the Firebase Cloud Messaging token. This means that the app should connect with firebase to
  receive the token.

End points

- [X]  The `register` endpoint returns a `201` status code if the user is successfully registered and a `400` status
  code if the user is not successfully registered. This returns the `otp` that will be needed for verification.
- [X]  The `login` endpoint returns a `200` status code if the user is successfully logged in and a `400` status code if
  the user is not successfully logged in. This returns the `otp` that will be needed for verification.
- [X]  The `verify` endpoint returns a `200` status code if the user is successfully verified and a `400` status code if
  the user is not successfully verified. After sending `register` and `login` requests, `verify` request will be sent
  immediately after to confirm the login status.
- [X]  The `me` endpoint returns the information of the logged-in user.
- [X]  The `products` endpoint returns a list of products only when user is connected.

## Points to remember

- [X]  The cookie should be sent in the header.
- [x]  `X-DID` and `identity` are one and the same thing. `X-DID` is used as header, and `identity` as entry in the body
  of the request. Both should carry the same value.

## How it works behind

- [x] The app is linked to Firebase Cloud Messaging project to retrieve the `fcm_token`, which is stored locally.
- [x] The app retrieves the device unique ID, `identity`, which is stored locally.
- [x] At load time, the app tries to retrieve saved `phone`, `dial_code` and `identity` from local storage.
- [x] If these are not found, the app displays the login page.
- [x] If these are found, the app sends a silent `login` request to the server.
- [x] If the `login` request is successful, the app sends a `verify` request to the server.
- [x] If the `verify` request is successful, the app sends a `me` request to the server.
- [x] If the `verify` request is not successful, the app displays the login page.
- [x] If the user has no account yet, he can go to the registration page and initiate registration.
- [x] If the `register` request is successful, the app sends a `verify` request to the server.
- [x] If the user has an account, he can go to the login page and initiate login.
- [x] If the `login` request is successful, the app sends a `verify` request to the server.
- [x] If the `verify` request is successful, the app sends a `me` request to the server.
- [x] If the `me` request is successful, the app displays the home page.
- [x] If the `me` request is not successful, the app displays the login page.
- [x] If the user is logged in, the app displays the home page.
- [x] If the user is not logged in, the app displays the login page.
- [x] If the user is logged in, he can go to the profile page to see his information.
- [x] If the user is logged in, he can go to the home page to see the list of products.
- [x] If the user is logged in, he can go to the details page of a product to see the details of the product.
- [x] From the profile page, the user can log out and be redirected to `login` page.

## Libraries Used

- [x] [Device Info Plus](https://pub.dev/packages/device_info_plus) : A powerful device information library for Dart,
  which supports getting device information.
- [X]  [Dio](https://pub.dev/packages/dio) : A powerful Http client for Dart, which supports Interceptors, FormData,
  Request Cancellation, File Downloading, Timeout etc.
- [X]  [Dio Cookie Manager](https://pub.dev/packages/dio_cookie_manager) : A cookie manager for Dio, which supports
  persistent cookies, session cookies, cookie storage etc.
- [X]  [Cookie Jar](https://pub.dev/packages/cookie_jar) : A cookie manager for Dart, which supports persistent cookies,
  session cookies, cookie storage etc.
- [X]  [GetX](https://pub.dev/packages/get) : A powerful state management library for Dart, which supports Dependency
  Injection, Routing and a lot more.
- [X]  [GetStorage](https://pub.dev/packages/get_storage) : A powerful storage library for Dart, which supports
  persistent storage.
- [x]  [intl](https://pub.dev/packages/intl) : Provides internationalization and localization facilities, including
  message translation, plurals and genders, date/number formatting and parsing, and bidirectional text.
- [x]  [Firebase Core](https://pub.dev/packages/firebase_core) : A Flutter plugin to use the Firebase Core API, which
  enables connecting to multiple Firebase apps.
- [x]  [Firebase Messaging](https://pub.dev/packages/firebase_messaging): A Flutter plugin to use the Firebase Cloud
  Messaging API.
