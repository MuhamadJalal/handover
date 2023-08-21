import 'package:get/get.dart';

class RateViewModel extends GetxController {
  RxDouble rateValue = RxDouble(0.0);

  void onValueChanged(double value) {
    rateValue.value = value;
    update();
  }
}
