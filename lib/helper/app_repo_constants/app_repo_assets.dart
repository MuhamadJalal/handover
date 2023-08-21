class AppRepoAssets {
  AppRepoAssets._internal();

  static final AppRepoAssets _instance = AppRepoAssets._internal();

  factory AppRepoAssets() => _instance;

  final String appFontFamily = 'montserrat';

  final String backImage = 'assets/images/back.png';
  final String catImage = 'assets/images/cat.png';
  final String deliveryImage = 'assets/images/delivery.png';
  final String markerImage = 'assets/images/marker.png';
  final String pickupImage = 'assets/images/pickup.png';
}
