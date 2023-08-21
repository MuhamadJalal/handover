import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handover/di/injector.dart';
import 'package:handover/helper/barrel_helper.dart';
import 'package:handover/repository/barrel_repository.dart';
import 'package:handover/view/common_widget/barrel_common_widget.dart';
import 'package:handover/view/screens/trip_summary_screens/trip_status_screen.dart';
import 'package:handover/view/screens/trip_summary_screens/trip_summary_screen.dart';
import 'package:handover/view_model/barrel_view_model.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: GetBuilder<BusDriversViewModel>(
          init: getIt<BusDriversViewModel>(),
          initState: (_) {
            Future.delayed(Duration.zero, () {
              getIt<BusDriversViewModel>().resetTripStatus();
              getIt<BusDriversViewModel>().getCurrentLocation();
              return 'Try clicking on each status to simulate trip\'s status changes'.textToast();
            });
          },
          builder: (userLocationViewModel) => Stack(
            children: [
              Center(
                child: SizedBox(
                  width: 100.safeBlockHorizontal(),
                  child: Stack(children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(target: userLocationViewModel.pickupLocationData, zoom: 9.5),
                      minMaxZoomPreference: const MinMaxZoomPreference(0, 16),
                      zoomGesturesEnabled: true,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      indoorViewEnabled: true,
                      mapType: MapType.terrain,
                      markers: userLocationViewModel.markersSet,
                      onMapCreated: (controller) => userLocationViewModel.googleMapController = controller,
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: SizedBox(
                        height: (userLocationViewModel.tripStatus.value == TripStatus.completed ? 75 : 50).safeBlockVertical(),
                        width: 100.safeBlockHorizontal(),
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              top: 7.5.safeBlockVertical(),
                              child: InkWell(
                                onTap: () {
                                  if (userLocationViewModel.googleMapController != null) {
                                    userLocationViewModel.googleMapController!
                                        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: userLocationViewModel.userLocationData.value!, zoom: 9.5)));
                                  }
                                },
                                child: CustomRoundedWidgetButton(
                                  borderRadius: AppRepoSizes().onlyTopCircularCornerRadius,
                                  backgroundColor: AppRepoColors().appPrimaryColor,
                                  withShadow: true,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 10.safeBlockVertical()),
                                      CustomText(
                                        text: 'Muhamad Jalal',
                                        textAlign: TextAlign.center,
                                        fontSize: 5.0.fontSize(),
                                        fontWeight: FontWeight.w600,
                                        textColor: AppRepoColors().appFontBlackColor,
                                      ),
                                      SizedBox(height: 4.safeBlockVertical()),
                                      Expanded(child: userLocationViewModel.tripStatus.value != TripStatus.completed ? const TripStatusWidget() : const TripSummaryWidget()),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            CustomImageProvider(
                              imagePath: AppRepoAssets().catImage,
                              boxFit: BoxFit.fill,
                              height: 30.safeBlockHorizontal(),
                              width: 30.safeBlockHorizontal(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ),

              /// back button
              Positioned(
                left: 0,
                right: 0,
                top: 4.safeBlockVertical(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomRoundedWidgetButton(
                      height: 12.safeBlockVertical(),
                      width: 12.safeBlockHorizontal(),
                      borderRadius: AppRepoSizes().smallCardCornerRadius,
                      backgroundColor: AppRepoColors().appGreyColor.withOpacity(0.5),
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.symmetric(vertical: 1.safeBlockVertical()),
                      child: CustomImageProvider(
                        onTap: Get.back,
                        imagePath: AppRepoAssets().backImage,
                        boxFit: BoxFit.scaleDown,
                        height: 7.safeBlockHorizontal(),
                        width: 7.safeBlockHorizontal(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
