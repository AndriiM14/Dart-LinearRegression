T asNumType<T extends num>(num n) {
  return 0.0 is T ? n.toDouble() as T : n.toInt() as T;
}

bool isNumeric(String s) {
  return double.tryParse(s) != null;
}
