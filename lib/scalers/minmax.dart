import 'package:linearregression_dart/dataframe.dart';
import 'package:linearregression_dart/scalers/scaler.dart';
import 'package:linearregression_dart/vector.dart';

class MinMaxScaler<T extends num> implements Scaler<T> {
  @override
  Dataframe<T> scaleDf(Dataframe<T> df) {
    // Works wrong!!!;
    Data<T> scaledData = {};
    for (final columnKey in df.columns) {
      scaledData[columnKey] = this.scaleV(df[columnKey]);
    }

    return Dataframe(scaledData);
  }

  @override
  Vector<T> scaleV(Vector<T> v) {
    final minVector = Vector.fill(v.dimensions, v.min);
    final minmaxVector = Vector.fill(v.dimensions, v.max - v.min as T);

    return (v - minVector) / minmaxVector;
  }
}
