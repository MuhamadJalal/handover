import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handover/di/injector.dart';
import 'package:handover/helper/barrel_helper.dart';
import 'package:handover/view/common_widget/barrel_common_widget.dart';
import 'package:handover/view_model/barrel_view_model.dart';

class TripStatusWidget extends StatelessWidget {
  const TripStatusWidget({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<BusDriversViewModel>(
        init: getIt<BusDriversViewModel>(),
        builder: (busDriversViewModel) => Column(
          children: busDriversViewModel.deliveryModelsList
              .map((deliveryModel) => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 4.safeBlockHorizontal()),
                      Column(
                        children: [
                          CustomRoundedWidgetButton(
                            height: 4.0.safeBlockHorizontal(),
                            width: 4.0.safeBlockHorizontal(),
                            borderRadius: AppRepoSizes().circularCornerRadius,
                            backgroundColor: busDriversViewModel.completedDeliveryModelList.contains(deliveryModel) ? AppRepoColors().appBlackColor : AppRepoColors().appAccentColor,
                            alignment: Alignment.center,
                          ),
                          if (!deliveryModel.isLast)
                            CustomRoundedWidgetButton(
                              height: 3.5.safeBlockVertical(),
                              width: .75.safeBlockHorizontal(),
                              borderRadius: AppRepoSizes().circularCornerRadius,
                              backgroundColor: busDriversViewModel.completedDeliveryModelList.contains(deliveryModel) ? AppRepoColors().appBlackColor : AppRepoColors().appAccentColor,
                              alignment: Alignment.center,
                            ),
                        ],
                      ),
                      SizedBox(width: 2.safeBlockHorizontal()),
                      Transform.translate(
                        offset: Offset(0, -1.1.safeBlockVertical()),
                        child: CustomText(
                          onTap: () => busDriversViewModel.changeTripStatus(deliveryModel),
                          text: deliveryModel.title,
                          textAlign: TextAlign.start,
                          fontSize: 4.0.fontSize(),
                          fontWeight: FontWeight.w500,
                          textColor: AppRepoColors().appFontWhiteColor,
                        ),
                      ),
                    ],
                  ))
              .toList(),
        ),
      );
}
