import 'package:flutter/foundation.dart';

import '../../di/di.dart';

const _kAuthenticatedScope = 'authenticated';

/// Register dependencies available for authenticated users.
VoidCallback registerAuthenticatedDependencies() {
  // TODO: placeholder to add authenticated dependencies...

  /// Reset authenticated dependencies.
  return () {
    if (getIt.currentScopeName == _kAuthenticatedScope) {
      getIt.popScope();
    }
  };
}
