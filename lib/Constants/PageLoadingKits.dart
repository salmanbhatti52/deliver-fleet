import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Colors.dart';

Center spinKitRotatingCircle = const Center(
  child: SizedBox(
    width: 200,
    height: 90,
    child: SpinKitWaveSpinner(
      waveColor: orange,
      color: orange,
      size: 90.0,
    ),
  ),
);
