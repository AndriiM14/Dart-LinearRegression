import 'package:linearregression_dart/linearregression_dart.dart';
import 'package:linearregression_dart/vector.dart';

void main(List<String> arguments) {
  var X = List.generate(100, (index) => Vector([(index + 1) / 100]));
  var y = Vector(List.generate(100, (index) => ((index + 1) * 2) / 200));

  final regressor = LinearRegression(X: X, y: y, learningRate: 0.001);
  regressor.fit(1000);

  print(regressor.accuracy());
  print(y);
  print(regressor.predictions);
}
