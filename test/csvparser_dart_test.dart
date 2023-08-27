import 'package:linearregression_dart/parsers/csv_parser.dart';

void main() async {
  final parser = CsvParser<double>();

  final housingData = await parser
      .parse('/Users/andrii/projects/Dart-LinearRegression/data/housing.csv');

  print(housingData.shape);
  print(housingData.columns);
  print(housingData);
}
