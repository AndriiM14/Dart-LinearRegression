import 'package:linearregression_dart/linearregression_dart.dart';
import 'package:linearregression_dart/parsers/csv_parser.dart';
import 'package:linearregression_dart/scalers/minmax.dart';

void main(List<String> arguments) async {
  const path = '/Users/andrii/projects/Dart-LinearRegression/data/housing.csv';

  final parser = CsvParser<double>();

  var housingData = await parser.parse(path);

  housingData.columns = [
    'price',
    'area',
    'bedrooms',
    'bathrooms',
    'stories',
    'parking'
  ];

  print(housingData);

  final scaler = MinMaxScaler<double>();
  housingData = scaler.scaleDf(housingData);

  print(housingData);

  var X = housingData.drop('price').toVectors();
  var y = housingData['price'];

  final regressor = LinearRegression(X: X, y: y, learningRate: 0.001);
  regressor.fit(1000);

  print(regressor.accuracy());
  print(y);
  print(regressor.predictions);
}
