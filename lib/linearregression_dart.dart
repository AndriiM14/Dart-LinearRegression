import 'package:linearregression_dart/vector.dart';

class LinearRegression {
  // ignore: non_constant_identifier_names
  Matrix<double> _X = [];
  Vector<double> _y = Vector([]);
  Vector<double> _w = Vector([]);
  double learningRate = 0.001;

  LinearRegression(
      {required Matrix<double> X,
      required Vector y,
      this.learningRate = 0.0001}) {
    _X = List.generate(
        X.length, (index) => Vector([1.0]).concat(X[index].toDouble()));
    _y = y.toDouble();

    if (_X.isNotEmpty) {
      _w = Vector.zeros(_X[0].dimensions);
    }
  }

  double predict(Vector<double> x) => _w.dot(x);

  Vector<double> get predictions => Vector(_X.map(predict).toList());

  Vector<double> gradient() {
    Vector<double> sum = Vector.zeros(_w.dimensions);

    for (final (index, Vector<double> x) in _X.indexed) {
      sum += x.mulByScalar(predict(x) - _y[index]);
    }

    return sum;
  }

  double accuracy() {
    return (predictions - _y)
            .reduce((value, element) => value + (1.0 - element.abs())) /
        _y.dimensions;
  }

  void fit([maxIterations = 1000]) {
    for (int i = 0; i < maxIterations; ++i) {
      _w = _w - gradient().mulByScalar(learningRate);
    }
  }
}
