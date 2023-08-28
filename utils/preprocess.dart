import 'dart:convert';
import 'dart:io';

import 'package:linearregression_dart/numeric.dart';

Future<void> eliminateNonNumericalData(String path) async {
  final file = File(path);
  Stream<String> data =
      file.openRead().transform(utf8.decoder).transform(LineSplitter());

  String processed = '';

  try {
    await for (final line in data) {
      List<String> row = [];

      for (final val in line.split(',')) {
        if (isNumeric(val)) row.add(val);
      }

      processed += '${row.join(',')}\n';
    }
  } catch (e) {
    print(e);
    return;
  }

  try {
    await file.writeAsString(processed).then((value) {
      print('Succecfuly eliminated non numerical values in $path');
    });
  } catch (e) {
    print(e);
  }
}
