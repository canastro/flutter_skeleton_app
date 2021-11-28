import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

@immutable
class RequestCancelled implements NetworkExceptions {
  const RequestCancelled();
}

@immutable
class UnauthorizedRequest implements NetworkExceptions {
  const UnauthorizedRequest();
}

@immutable
class BadRequest implements NetworkExceptions {
  const BadRequest();
}

@immutable
class NotFound implements NetworkExceptions {
  final String reason;

  const NotFound(this.reason);
}

@immutable
class MethodNotAllowed implements NetworkExceptions {
  const MethodNotAllowed();
}

@immutable
class NotAcceptable implements NetworkExceptions {
  const NotAcceptable();
}

@immutable
class RequestTimeout implements NetworkExceptions {
  const RequestTimeout();
}

@immutable
class SendTimeout implements NetworkExceptions {
  const SendTimeout();
}

@immutable
class Conflict implements NetworkExceptions {
  const Conflict();
}

@immutable
class InternalServerError implements NetworkExceptions {
  const InternalServerError();
}

@immutable
class NotImplemented implements NetworkExceptions {
  const NotImplemented();
}

@immutable
class ServiceUnavailable implements NetworkExceptions {
  const ServiceUnavailable();
}

@immutable
class NoInternetConnection implements NetworkExceptions {
  const NoInternetConnection();
}

@immutable
class FormatException implements NetworkExceptions {
  const FormatException();
}

@immutable
class UnableToProcess implements NetworkExceptions {
  const UnableToProcess();
}

@immutable
class DefaultError implements NetworkExceptions {
  final String error;

  const DefaultError(this.error);
}

@immutable
class UnexpectedError implements NetworkExceptions {
  const UnexpectedError();
}

abstract class NetworkExceptions extends Exception {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;

  const factory NetworkExceptions.unauthorizedRequest() = UnauthorizedRequest;

  const factory NetworkExceptions.badRequest() = BadRequest;

  const factory NetworkExceptions.notFound(String reason) = NotFound;

  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.conflict() = Conflict;

  const factory NetworkExceptions.internalServerError() = InternalServerError;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.defaultError(String error) = DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  static NetworkExceptions handleResponse(int statusCode) {
    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        return const NetworkExceptions.unauthorizedRequest();
      case 404:
        return const NetworkExceptions.notFound('Not found');
      case 409:
        return const NetworkExceptions.conflict();
      case 408:
        return const NetworkExceptions.requestTimeout();
      case 500:
        return const NetworkExceptions.internalServerError();
      case 503:
        return const NetworkExceptions.serviceUnavailable();
      default:
        final responseCode = statusCode;
        return NetworkExceptions.defaultError(
          'Received invalid status code: $responseCode',
        );
    }
  }

  static NetworkExceptions getDioException(dynamic error) {
    if (error is Exception) {
      try {
        NetworkExceptions networkExceptions;
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              networkExceptions = const NetworkExceptions.requestCancelled();
              break;
            case DioErrorType.connectTimeout:
              networkExceptions = const NetworkExceptions.requestTimeout();
              break;
            case DioErrorType.other:
              networkExceptions =
                  const NetworkExceptions.noInternetConnection();
              break;
            case DioErrorType.receiveTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioErrorType.response:
              networkExceptions =
                  NetworkExceptions.handleResponse(error.response!.statusCode!);
              break;
            case DioErrorType.sendTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = const NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions = const NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException catch (_) {
        // Helper.printError(e.toString());
        return const NetworkExceptions.formatException();
      } on Exception catch (_) {
        return const NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains('is not a subtype of')) {
        return const NetworkExceptions.unableToProcess();
      } else {
        return const NetworkExceptions.unexpectedError();
      }
    }
  }
}
