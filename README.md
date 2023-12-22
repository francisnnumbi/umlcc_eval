# umlcc_eval

A flutter project for evaluation

## Task Description

Creating an application with the following points :

- [x] A login page
- [x] A registration page
- [x] A verification page
- [x] A home page with a list of products
- [x] A me page

## Endpoints

These are stated in the app's `lib/api/endpoints.dart` file.

## Particularities of Requests

Cookie should be sent inside the header of the request with the key `X-DID` and the value `Bearer $token` where `$token`
is the token received after a successful login.

### Me Get Request :

```"X-DID", 'Authorization':'Bearer $token'```

### Register Post Request :

```("dial_code", "first_name", "last_name", "identity", "phone"), type = "individual"```

### Login Post Request :

```("dial_code", "phone", "identity")```

### Verify Post Request :

```("dial_code", "phone", "identity", "code")```

### Products Get Request :

```"X-DID", 'Authorization':'Bearer $token', "Accept":"application/json"```

## Points to Clarify

- [x] The `identity` field is the email address of the user.
- [x] The `dial_code` field is the country code of the user.
- [x] The `phone` field is the phone number of the user.
- [x] The `code` field is the verification code sent to the user's phone number, or `otp`.
- [x] The `type` field is the type of user. It can be either `individual` or `company`.
- [x] The `token` field is the token received after a successful login.
- [x] The `X-DID` field is the cookie sent with the request.
- [x] The `Accept` field is the header sent with the request stating the type of data that is expected to be received.
- [x] The `Authorization` field is the header sent with the request.
- [x] The `Bearer`is the type of authorization attached as value of `Authorization` and is concatenated with
  the `token`.
- [x] The `me` endpoint returns a `200` status code if the user is logged in and a `401` status code if the user is not
  logged in.
- [x] The `register` endpoint returns a `201` status code if the user is successfully registered and a `400` status code
  if the user is not successfully registered.
- [x] The `login` endpoint returns a `200` status code if the user is successfully logged in and a `400` status code if
  the user is not successfully logged in.
- [x] The `verify` endpoint returns a `200` status code if the user is successfully verified and a `400` status code if
  the user is not successfully verified.
- [x] The `products` endpoint returns a `200` status code if the user is successfully logged in and a `401` status code
  if the user is not successfully logged in.

## Points to remember

- [x] The cookie should be sent in the header.

## Encountered Problems

Register

- [ ] The `X-AU30` cookie was received with the response, but is not related to any expected cookie.
- [ ] The `ensurance_session` cookie was received with the response, but is not related to any expected cookie.

- [x] The `X-DID` was not received with the response.
- [x] The `token` was not received with the response.

Verify

- [ ] The `fcm_token` field is required, but was not received with the previous response.

- [ ] The `ensurance_session` cookie was received with the response, but is not related to any expected cookie.
- [x] `422 Unprocessable Entity` status code was received with the Exception, thrown
  by `RequestOptions.validateStatus`, `Client error - the request contains bad syntax or cannot be fulfilled`.

Login

- [ ] The `ensurance_session` cookie was received with the response, but is not related to any expected cookie.
- [x] `403 Forbidden` status code was received with the Exception, thrown by `RequestOptions.validateStatus`.

Me

- [ ] Not tested yet.

Products

- [ ] Not tested yet.

## Libraries Used

- [x] [Dio](https://pub.dev/packages/dio)
- [x] [GetX](https://pub.dev/packages/get)
- [x] [GetStorage](https://pub.dev/packages/get_storage)


