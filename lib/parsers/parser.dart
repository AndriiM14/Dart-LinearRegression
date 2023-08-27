import 'package:linearregression_dart/dataframe.dart';

abstract class Parser<T extends num> {
  Future<Dataframe<T>> parse(String path);
}
