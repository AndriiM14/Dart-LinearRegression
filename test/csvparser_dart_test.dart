import 'package:linearregression_dart/parsers/csv_parser.dart';

void main() async {
  const path = '/Users/andrii/projects/Dart-LinearRegression/data/housing.csv';

  final parser = CsvParser<double>();

  final housingData = await parser.parse(path);

  print(housingData.shape);
  print(housingData.columns);
  print(housingData);

  housingData.columns = [
    'price',
    'area',
    'bedrooms',
    'bathrooms',
    'stories',
    'parking'
  ];

  print(housingData.shape);
  print(housingData.columns);
  print(housingData);
}
