void main(List<String> args) {
  const String a = 'NikitaMarek';

  print(a);

  for (var item in a.allMatches('a').toList()) {
    print(item);
  }
}
