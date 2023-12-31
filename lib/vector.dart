import 'dart:collection';
import 'dart:math' as math show min, max;
import 'package:linearregression_dart/numeric.dart';

class _VectorDimensionsException implements Exception {
  final int v1Dimensions;
  final int v2Dimensions;

  const _VectorDimensionsException(this.v1Dimensions, this.v2Dimensions);

  @override
  String toString() {
    return 'VectorDimensionsException: vectors need to have the same number of dimensions.\n Number of dimensions for the first vector: $v1Dimensions.\n Number of dimensions for the second vector: $v2Dimensions.';
  }
}

typedef Matrix<T extends num> = List<Vector<T>>;

typedef MatrixShape = ({int rows, int columns});

MatrixShape matrixShape(Matrix matrix) {
  return (
    rows: matrix.length,
    columns: (matrix.isNotEmpty ? matrix[0].dimensions : 0)
  );
}

class Vector<T extends num> extends IterableMixin<T> {
  List<T> _data = [];

  int get dimensions => _data.length;

  T get min => _data.reduce(math.min);
  T get max => _data.reduce(math.max);

  static checkDimensions(Vector a, Vector b) {
    if (a.dimensions != b.dimensions) {
      throw _VectorDimensionsException(a.dimensions, b.dimensions);
    }
  }

  Vector(this._data);

  Vector.zeros(int length) {
    _data = List<T>.generate(length, (index) => asNumType<T>(0));
  }

  Vector.ones(int length) {
    _data = List<T>.generate(length, (index) => asNumType<T>(1));
  }

  Vector.fill(int length, T element) {
    _data = List<T>.generate(length, (index) => element);
  }

  @override
  T reduce(T Function(T value, T element) combine) {
    return _data.reduce(combine);
  }

  Vector<T> sum(Vector<T> v) {
    Vector.checkDimensions(this, v);

    return Vector(
        List<T>.generate(dimensions, (index) => (this[index] + v[index]) as T));
  }

  Vector<T> substract(Vector<T> v) {
    Vector.checkDimensions(this, v);

    return Vector(
        List<T>.generate(dimensions, (index) => (this[index] - v[index]) as T));
  }

  Vector<T> mul(Vector<T> v) {
    Vector.checkDimensions(this, v);

    return Vector(
        List<T>.generate(dimensions, (index) => (this[index] * v[index]) as T));
  }

  Vector<T> divide(Vector<T> v) {
    Vector.checkDimensions(this, v);

    return Vector(List.generate(
        dimensions, (index) => asNumType<T>(this[index] / v[index])));
  }

  double dot(Vector<T> v) {
    return (this * v)
        .reduce((value, element) => value + element as T)
        .toDouble();
  }

  Vector<T> concat(Vector<T> v) {
    return Vector([...this, ...v]);
  }

  Vector<T> mulByScalar(T a) {
    return Vector(List.generate(dimensions, (index) => (this[index] * a) as T));
  }

  Vector<double> toDouble() => Vector(map((e) => e.toDouble()).toList());

  T operator [](int index) => _data[index];
  Vector<T> operator +(Vector<T> v) => sum(v);
  Vector<T> operator -(Vector<T> v) => substract(v);
  Vector<T> operator *(Vector<T> v) => mul(v);
  Vector<T> operator /(Vector<T> v) => divide(v);

  @override
  String toString() {
    return 'Vector($_data, dtype=$T)';
  }

  @override
  Iterator<T> get iterator => _data.iterator;
}
