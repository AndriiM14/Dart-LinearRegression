import 'package:linearregression_dart/vector.dart';
import 'package:tabular/tabular.dart';

class NoSuchColumnException implements Exception {
  final String columnKey;

  NoSuchColumnException(this.columnKey);

  @override
  String toString() {
    return "No such column: '$columnKey' in dataframe";
  }
}

typedef Data<T extends num> = Map<String, Vector<T>>;

typedef Shape = ({int rows, int columns});

class Dataframe<T extends num> {
  Data<T> _data = {};

  Shape get shape => (
        rows: _data.values.isNotEmpty
            ? _data.values.toList().first.dimensions
            : 0,
        columns: _data.keys.length
      );

  List<String> get columns => _data.keys.toList();

  Dataframe(this._data);

  Dataframe.fromVectors(
      {required Matrix<T> data, required List<String> columns}) {
    final shape = matrixShape(data);

    for (int i = 0; i < shape.columns; ++i) {
      List<T> currentColumn = [];

      for (int j = 0; j < shape.rows; ++j) {
        currentColumn.add(data[j][i]);
      }

      _data[columns[i]] = Vector(currentColumn);
    }
  }

  Matrix<T> toVectors() {
    Matrix<T> matrix = [];

    for (int i = 0; i < shape.rows; ++i) {
      List<T> row = [];

      for (final v in _data.values) {
        row.add(v[i]);
      }

      matrix.add(Vector(row));
    }

    return matrix;
  }

  Dataframe<T> drop(String columnKey) {
    var dataCpy = Data<T>.from(_data);
    dataCpy.remove(columnKey);

    return Dataframe(dataCpy);
  }

  Vector<T> operator [](String columnKey) {
    Vector<T>? v = _data[columnKey];

    if (v == null) {
      throw NoSuchColumnException(columnKey);
    }

    return v;
  }

  List<List<String>> _toTable() {
    List<List<String>> table = [_data.keys.toList()];

    for (int i = 0; i < shape.rows; ++i) {
      List<String> row = [];

      for (final v in _data.values) {
        row.add(v[i].toString());
      }

      table.add(row);
    }

    return table;
  }

  @override
  String toString() {
    return tabular(_toTable());
  }
}
