import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handover/helper/barrel_helper.dart';
import 'package:handover/models/barrel_models.dart';
import 'package:handover/repository/barrel_repository.dart';
import 'package:handover/view_model/firebase_view_model.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class BusDriversViewModel extends GetxController {
  List<DeliveryModel> deliveryModelsList = DeliveryRepository().deliveryModelsList;
  RxList<DeliveryModel> completedDeliveryModelList = RxList();
  Rx<TripStatus> tripStatus = Rx(TripStatus.waiting);

  /// map screen
  late GoogleMapController? googleMapController;
  Location location = Location();

  /// EGP
  // LatLng pickupLocationData = const LatLng(30.04923853206856, 31.234648570912942);
  // LatLng deliveryLocationData = const LatLng(30.043908, 31.246059);

  /// KSA
  LatLng pickupLocationData = const LatLng(24.648775686213718, 46.94957966390889);
  LatLng deliveryLocationData = const LatLng(24.88811243373081, 46.55982427899553);
  Rxn<LatLng> userLocationData = Rxn();
  RxSet<Marker> markersSet = RxSet();
  RxBool isGettingLocation = RxBool(false);

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  getCurrentLocation() async {
    bool isLocationDenied = await Permission.location.isDenied;
    bool isLocationPermanentlyDenied = await Permission.location.isPermanentlyDenied;
    bool isLocationRestricted = await Permission.location.isRestricted;

    if (isLocationDenied) location.requestPermission().then((value) => "permission requestPermission value $value".debug(this));
    // if(isLocationDenied || isLocationRestricted) openAppSettings();

    "permission isLocationDenied $isLocationDenied".debug(this);
    "permission isLocationPermanentlyDenied $isLocationPermanentlyDenied".debug(this);
    "permission isLocationRestricted $isLocationRestricted".debug(this);
    "permission locationData locationData".debug(this);
    isGettingLocation.value = true;
    update();

    geolocator.GeolocatorPlatform.instance.getCurrentPosition(locationSettings: const geolocator.LocationSettings(accuracy: geolocator.LocationAccuracy.best)).then((locationData) async {
      "getCurrentLocation2 permission locationData $locationData".debug(this);

      isGettingLocation.value = false;
      userLocationData(LatLng(locationData.latitude, locationData.longitude));
      // LatLng(userLocationData.value?.latitude ?? 0, userLocationData.value?.longitude ?? 0);

      markersSet.addAll({
        Marker(
          markerId: const MarkerId('userLocationData'),
          position: userLocationData.value!,
          icon: BitmapDescriptor.fromBytes(await getBytesFromAsset(AppRepoAssets().markerImage, 50)),
        ),
        Marker(
          markerId: const MarkerId('pickupLocationData'),
          position: pickupLocationData,
          icon: BitmapDescriptor.fromBytes(await getBytesFromAsset(AppRepoAssets().pickupImage, 150)),
          // icon: await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(4.safeBlockHorizontal(), 4.safeBlockHorizontal())), AppRepoAssets().catImage),
        ),
        Marker(
          markerId: const MarkerId('deliveryLocationData'),
          position: deliveryLocationData,
          icon: BitmapDescriptor.fromBytes(await getBytesFromAsset(AppRepoAssets().deliveryImage, 150)),
          // icon: await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(24, 24)), AppRepoAssets().catImage),
        ),
      });

      update();
    }).onError((error, stackTrace) {
      isGettingLocation.value = false;
      update();
      "getCurrentLocation2 permission error $error".debug(this);
    });
  }

  void resetTripStatus() {
    completedDeliveryModelList.clear();
    tripStatus.value = TripStatus.coming;
    update();
  }

  Future<void> changeTripStatus(DeliveryModel deliveryModel) async {
    'void changeTripStatus(${deliveryModel.tripStatus})'.debug(this);
    tripStatus.value = deliveryModel.tripStatus;
    if (completedDeliveryModelList.contains(deliveryModel)) {
      completedDeliveryModelList.clear();
      if (deliveryModel.tripStatus != TripStatus.coming) {
        completedDeliveryModelList.addAll(deliveryModelsList.getRange(0, deliveryModelsList.indexOf(deliveryModel)));
      } else {
        completedDeliveryModelList.add(deliveryModel);
      }
    } else {
      completedDeliveryModelList.clear();
      if (deliveryModel.tripStatus != TripStatus.completed) {
        completedDeliveryModelList.addAll(deliveryModelsList.getRange(0, deliveryModelsList.indexOf(deliveryModel) + 1));
      }
    }

    String notificationMsg = completedDeliveryModelList.isEmpty
        ? 'The shipment arrived, confirm please :)'
        : completedDeliveryModelList.last.tripStatus == TripStatus.waiting
            ? 'The trip status updated to waiting state!'
            : completedDeliveryModelList.last.tripStatus == TripStatus.coming
                ? 'The trip started and our driver going to pick your shipment!'
                : completedDeliveryModelList.last.tripStatus == TripStatus.pickUp
                    ? 'Your shipment on its way!'
                    : completedDeliveryModelList.last.tripStatus == TripStatus.nearDelivery
                        ? 'The shipment approximately arrived, be ready!'
                        : 'The shipment arrived, confirm please :)';

    String userToken = (await FirebaseViewModel().getUserToken())!;
    'void changeTripStatus( userToken $userToken)'.debug(this);
    FirebaseViewModel().sendNotification(userToken: userToken, title: 'Sabbar', bodyMsg: notificationMsg);
    update();
  }

  void initState(GetBuilderState<BusDriversViewModel> state) {
    Future.wait([
      Permission.location.request(),
      Permission.locationAlways.request(),
    ]).then((value) async {
      // if (!(await Permission.location.isGranted) || !(await Permission.locationAlways.isGranted)) {
      //   AppTranslations.allowLocationAccessMsg.textToast();
      // } else {
      return getCurrentLocation();
      // }
    });
  }
}
