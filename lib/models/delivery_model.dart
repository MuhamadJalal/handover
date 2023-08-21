import 'package:handover/repository/app_enums.dart';

class DeliveryModel {
  String title;
  TripStatus tripStatus;
  final bool isLast;

  DeliveryModel({required this.title, required this.tripStatus, this.isLast = false});

  void changeTripStatus(status) => tripStatus = status;
}
