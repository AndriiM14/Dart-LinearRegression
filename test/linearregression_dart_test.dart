import 'package:linearregression_dart/dataframe.dart' as df;
import 'package:linearregression_dart/linearregression_dart.dart';
import 'package:linearregression_dart/vector.dart';
import 'package:test/test.dart';

void main() {
  final foo = df.Dataframe({
    'column a': Vector([1, 2, 3]),
    'column b': Vector([4, 5, 6])
  });

  print(foo);

  final bar = foo.drop('column b');
  print(bar);

  final columB = foo['column b'];
  print(columB);

  print(foo.toVectors());

  final X = df.Dataframe.fromVectors(data: [
    Vector([1, 2, 3]),
    Vector([4, 5, 6]),
    Vector([7, 8, 9]),
  ], columns: [
    'a',
    'b',
    'c'
  ]);

  print(X);
  print(X.toVectors());
}
