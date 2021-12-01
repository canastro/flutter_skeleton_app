import 'package:flutter/widgets.dart';
import 'package:flutter_skeleton_app/src/core/data/http_client.dart';

import '../../../../core/data/exceptions.dart';
import '../../../../di/di.dart';
import '../../di.dart';
import '../../domain/use_cases/authenticate_user.dart';
import '../../domain/use_cases/load_session.dart';
import '../../domain/use_cases/logout.dart';

/// A state type for the [AuthenticationStore].
abstract class AuthState {}

/// Represents the state of the store before verification of
/// the stored session is completed.
class AuthStateInitial extends AuthState {}

/// Represents a loading state of the [AuthenticationStore].
class AuthStateLoading extends AuthState {}

/// Represents the error state of the [AuthenticationStore].
class AuthStateError extends AuthState {
  final Object? error;

  AuthStateError([this.error]);

  bool get isUnauthorized => error is UnauthorizedRequest;
}

/// Represents the authenticated state of the [AuthenticationStore].
class AuthStateAuthenticated extends AuthState {}

/// Represents the non authenticated state of the [AuthenticationStore].
class AuthStateNotAuthenticated extends AuthState {}

class AuthenticationStore extends ValueNotifier<AuthState> {
  final AuthenticateUserUseCase _authenticateUserUseCase =
      getIt<AuthenticateUserUseCase>();
  final LoadSessionUseCase _loadSessionUseCase = getIt<LoadSessionUseCase>();
  final HttpClient _httpClient = getIt<HttpClient>();

  VoidCallback? resetAuthenticatedDependencies;

  AuthenticationStore() : super(AuthStateInitial()) {
    loadSession();
  }

  /// Loads the session [value] from the [SharedPreferences] cache.
  Future<void> loadSession() async {
    final session = await _loadSessionUseCase();
    if (session != null) {
      value = AuthStateAuthenticated();
      _handleAuthenticated(session);
    } else {
      value = AuthStateNotAuthenticated();
    }
  }

  /// Handles invalid credentials from the initial graphql connection.
  Future<void> handleInvalidCredentials() async => logout(unauthorized: true);

  /// Calls the [AuthenticateUserUseCase] to login an user with the given
  /// credentials.
  Future<void> authenticate(String email, String password) async {
    try {
      value = AuthStateLoading();
      final session = await _authenticateUserUseCase(email, password);
      _handleAuthenticated(session);
    } on NetworkExceptions catch (error) {
      value = AuthStateError(error);
    }
  }

  /// Create the graphql [AuthenticatedGraphQLClient] with the given session,
  /// and register the dependencies in the getIt container.
  void _handleAuthenticated(String session) {
    _httpClient.session = session;

    resetAuthenticatedDependencies = registerAuthenticatedDependencies();
  }

  /// Calls [LogoutUseCase] and resets the state to it's initial value.
  Future<void> logout({bool? unauthorized}) async {
    final _logoutUseCase = getIt<LogoutUseCase>();

    try {
      await _logoutUseCase();
    } finally {
      assert(resetAuthenticatedDependencies != null);
      resetAuthenticatedDependencies!.call();

      if (unauthorized == true) {
        value = AuthStateError(const UnauthorizedRequest());
      } else {
        value = AuthStateNotAuthenticated();
      }
    }
  }
}
