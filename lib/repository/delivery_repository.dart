import 'package:handover/helper/app_localization/localizations.dart';
import 'package:handover/models/barrel_models.dart';
import 'package:handover/repository/app_enums.dart';

class DeliveryRepository {
  DeliveryRepository._internal();

  static final DeliveryRepository _instance = DeliveryRepository._internal();

  factory DeliveryRepository() => _instance;

  List<DeliveryModel> deliveryModelsList = [
    DeliveryModel(
      title: AppTranslations.onTheWay,
      tripStatus: TripStatus.coming,
    ),
    DeliveryModel(
      title: AppTranslations.pickedDelivery,
      tripStatus: TripStatus.pickUp,
    ),
    DeliveryModel(
      title: AppTranslations.nearDelivery,
      tripStatus: TripStatus.nearDelivery,
    ),
    DeliveryModel(
      title: AppTranslations.deliveredPackage,
      tripStatus: TripStatus.completed,
      isLast: true,
    ),
  ];
}
