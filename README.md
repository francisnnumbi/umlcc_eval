# umlcc_eval

A flutter project for evaluation

## Task Description

Creating an application with the following points :

- [X]  A login page
- [X]  A registration page
- [X]  A verification page
- [X]  A home page with a list of products
- [X]  A me or profile page

## Endpoints

These are stated in the app's `lib/api/endpoints.dart` file.

## Particularities of Requests

Cookie should be sent inside the header of the request with the key `X-DID` and the `Authorization` with
value `Bearer $token`
where `$token`
is the token received after a successful login.

### Register Post Request :

These go in the body of the request:

`dial_code`, `first_name`, `last_name`, `identity`, `phone`, `type="individual"`

### Verify Post Request :

these go in the body of the request:

`dial_code`, `phone`, `identity`, `code`

`code` is the verification code sent to the user's phone number, or `otp`.

`):` At this point, user should be verified and logged in order to perform the next requests.

### Login Post Request :

These go in the body of the request:

`dial_code`, `phone`, `identity`

### Me Get Request :

These go in the header of the request:

`X-DID`, `Authorization:'Bearer $token'`, `Accept:'application/json'`

### Products Get Request :

These go in the header of the request:

`X-DID`, `Authorization:'Bearer $token'`, `Accept:'application/json'`

## Points to Clarify

- [X]  The `identity` field is the email address of the user.
- [X]  The `dial_code` field is the country code of the user.
- [X]  The `phone` field is the phone number of the user.
- [X]  The `code` field is the verification code sent to the user's phone number, or `otp`.
- [X]  The `type` field is the type of user. It can be either `individual` or `company`.
- [X]  The `token` field is the token received after a successful login.
- [X]  The `X-DID` field is the device identity to be sent with the request.
- [X]  The `Accept` field is the header sent with the request stating the type of data that is expected to be received.
- [X]  The `Authorization` field is the header sent with the request.
- [X]  The `Bearer`is the type of authorization attached as value of `Authorization` and is concatenated with
  the `token`.
- [X]  The `fcm_token` is the firebase token. This means that the app should authenticate with firebase.
- [X]  The `me` endpoint returns a `200` status code if the user is logged in and a `401` status code if the user is not
  logged in.
- [X]  The `register` endpoint returns a `201` status code if the user is successfully registered and a `400` status
  code
  if the user is not successfully registered.
- [X]  The `login` endpoint returns a `200` status code if the user is successfully logged in and a `400` status code if
  the user is not successfully logged in.
- [X]  The `verify` endpoint returns a `200` status code if the user is successfully verified and a `400` status code if
  the user is not successfully verified.
- [X]  The `products` endpoint returns a `200` status code if the user is successfully logged in and a `401` status code
  if the user is not successfully logged in.

## Points to remember

- [X]  The cookie should be sent in the header.

## Encountered Problems

#### Register

- [ ]  The `X-AU30` cookie was received with the response, but is not related to any expected cookie. [SOLVED]
- [ ]  The `ensurance_session` cookie was received with the response, but is not related to any expected
  cookie. [SOLVED]
- [X]  The `X-DID` was not received with the response. [SOLVED]
- [X]  The `token` was not received with the response. [SOLVED]

#### Verify

- [ ]  The `fcm_token` field is required, but was not received with the previous response. [SOLVED]
- [ ]  The `ensurance_session` cookie was received with the response, but is not related to any expected
  cookie. [SOLVED]
- [X]  `422 Unprocessable Entity` status code was received with the Exception, thrown
  by `RequestOptions.validateStatus`, `Client error - the request contains bad syntax or cannot be fulfilled`. [SOLVED]

#### Login

- [ ]  The `ensurance_session` cookie was received with the response, but is not related to any expected
  cookie. [SOLVED]
- [X]  `403 Forbidden` status code was received with the Exception, thrown by `RequestOptions.validateStatus`. [SOLVED]

#### Me

- [X]  `401 Unauthorized` status code was received with the Exception, thrown
  by `RequestOptions.validateStatus`. [SOLVED]

#### Products

- [X]  `401 Unauthorized` status code was received with the Exception, thrown
  by `RequestOptions.validateStatus`. [SOLVED]

It seems that some terms are named differently in the task and in the code. And that some terms are missing in the task.
It's also possible that some instructions are missing in the task too.

## Libraries Used

- [x] [Firebase Messaging]
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
