class Utils {
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
