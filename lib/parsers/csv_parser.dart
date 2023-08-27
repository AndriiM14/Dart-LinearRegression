import 'dart:convert';
import 'dart:io';

import 'package:linearregression_dart/dataframe.dart';
import 'package:linearregression_dart/parsers/parser.dart';
import 'package:linearregression_dart/vector.dart';

class CsvParser<T extends num> implements Parser<T> {
  T convert(String element) {
    double? converted = double.tryParse(element);

    if (0.0 is T) {
      return converted != null ? converted as T : 0.0 as T;
    } else {
      return converted != null ? converted.toInt() as T : 0 as T;
    }
  }

  @override
  Future<Dataframe<T>> parse(String path) async {
    final source = File(path);
    Stream<String> lines =
        source.openRead().transform(utf8.decoder).transform(LineSplitter());

    Matrix<T> data = [];
    try {
      await for (final line in lines) {
        List<T> row = [];

        line.split(',').forEach((element) {
          row.add(convert(element));
        });

        data.add(Vector(row));
      }

      final shape = matrixShape(data);
      final columns = List.generate(shape.columns, (index) => index.toString());

      return Dataframe.fromVectors(data: data, columns: columns);
    } catch (e) {
      print(e);
      return Dataframe<T>({});
    }
  }
}
