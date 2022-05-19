import 'package:portfolio_uix/core/data/data.dart';
import 'package:portfolio_uix/core/constants/constants.dart';

class Utils {
  /// Validate the given [s].
  ///
  /// Return values:
  /// - [Email.empty] if [s] is empty
  /// - [Email.valid] if [s] is a valid email address
  /// - [Email.invalid] otherwise
  static Email validateEmail(final String s) {
    if (s.isNotEmpty) {
      return RegExp(Constants.emailRegExp).hasMatch(s)
          ? Email.valid
          : Email.invalid;
    } else {
      return Email.empty;
    }
  }

  static List<String> stringToList(
    final String _s, {
    final toUnderscores = false,
  }) {
    final List<String> undersores = [];

    if (toUnderscores) {
      for (var i = 0; i < _s.length; i++) {
        undersores.add('_');
      }
    } else {
      for (var i = 0; i < _s.length; i++) {
        undersores.add(_s[i]);
      }
    }

    return undersores;
  }

  static List<int> listUntil(final int _upperBound) {
    final List<int> _list = [];

    for (var i = 0; i < _upperBound; i++) {
      _list.add(i);
    }
    return _list;
  }
}
