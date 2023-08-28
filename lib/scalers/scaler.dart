import 'package:linearregression_dart/dataframe.dart';
import 'package:linearregression_dart/vector.dart';

abstract class Scaler<T extends num> {
  Dataframe<T> scaleDf(Dataframe<T> df);
  Vector<T> scaleV(Vector<T> v);
}
