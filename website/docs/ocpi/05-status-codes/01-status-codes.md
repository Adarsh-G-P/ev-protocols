---
sidebar_position: 5
slug: /ocpi/status-codes
---
# 🚦 Status codes

There are two types of status codes:

* Transport related (HTTP)
* Content related (OCPI)

The transport layer ends after a message is correctly parsed into a (semantically unvalidated) JSON structure. When a
message does not contain a valid JSON string, the HTTP error `400 - Bad request` MUST be returned.

If a request is syntactically valid JSON and addresses an existing resource, a HTTP error MUST NOT be returned. Those
requests are supposed to have reached the OCPI layer.

In case of a GET request, when the resource does NOT exist, the server SHOULD return a HTTP `404 - Not Found`.

When the server receives a valid OCPI object it SHOULD respond with:

* HTTP `200 - Ok` when the object already existed and has successfully been updated.
* HTTP `201 - Created` when the object has been newly created in the server system.

Requests that reach the OCPI layer SHOULD return an OCPI response message with a `status_code` field as defined below.

Custom status code range values SHALL NOT be used by standard OCPI module as described in this document! When custom
status codes are used, keep in mind that different custom modules could use the same values with a different meaning, as
they are not standardized.

| Range | Description                                                                    |
|-------|--------------------------------------------------------------------------------|
| 1xxx  | Success                                                                        |
| 2xxx  | Client errors - The data sent by the client can not be processed by the server |
| 3xxx  | Server errors - The server encountered an internal error                       |

When the status code is in the success range (1xxx), the `data` field in the response message SHOULD contain the
information as specified in the protocol. Otherwise the `data` field is unspecified and MAY be omitted, set to `null` or
something else that could help to debug the problem from a programmer's perspective. For example, it could specify which
fields contain an error or are missing.

## 1xxx: Success

| Code | Description                                                 |
|------|-------------------------------------------------------------|
| 1000 | Generic success code                                        |
| 19xx | Reserved range for custom success status codes (1900-1999). |

## 2xxx: Client errors

Errors detected by the server in the message sent by a client where the client did something wrong.

| Code | Description                                                                                   |
|------|-----------------------------------------------------------------------------------------------|
| 2000 | Generic client error                                                                          |
| 2001 | Invalid or missing parameters , for example: missing `last_updated` field in a PATCH request. |
| 2002 | Not enough information, for example: Authorization request with too little information.       |
| 2003 | Unknown Location, for example: Command: START_SESSION with unknown location.                  |
| 2004 | Unknown Token, for example: *real-time* authorization of an unknown Token.                    |
| 29xx | Reserved range for custom client error status codes (2900-2999).                              |

## 3xxx: Server errors

Error during processing of the OCPI payload in the server. The message was syntactically correct but could not be
processed by the server.

| Code | Description                                                                                                                                                                                                                                                                                              |
|------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 3000 | Generic server error                                                                                                                                                                                                                                                                                     |
| 3001 | Unable to use the client's API. For example during the credentials registration: When the initializing party requests data from the other party during the open POST call to its credentials endpoint. If one of the GETs can not be processed, the party should return this error in the POST response. |
| 3002 | Unsupported version                                                                                                                                                                                                                                                                                      |
| 3003 | No matching endpoints or expected endpoints missing between parties. Used during the registration process if the two parties do not have any mutual modules or endpoints available, or the minimal implementation expected by the other party is not been met.                                           |
| 39xx | Reserved range for custom server error status codes (3900-3999).                                                                                                                                                                                                                                         |

## 4xxx: Hub errors

When a server encounters an error, client side error (2xxx) or server side error (3xxx), it sends the status code to the
Hub. The Hub SHALL then forward this error to the client which sent the request (when the request was not a Broadcast
Push).

For errors that a Hub encounters while routing messages, the following OCPI status codes shall be used.

| Code | Description                                                                |
|------|----------------------------------------------------------------------------|
| 4000 | Generic error                                                              |
| 4001 | Unknown receiver (TO address is unknown)                                   |
| 4002 | Timeout on forwarded request (message is forwarded, but request times out) |
| 4003 | Connection problem (receiving party is not connected)                      |
| 49xx | Reserved range for custom hub error status codes (4900-4999).              |
