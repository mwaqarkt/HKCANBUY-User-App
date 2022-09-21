import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/application/locationProvider.dart';
import 'package:user_app/configurations/frontEndConfigs.dart';
import 'package:user_app/infrastructure/models/availableDayModel.dart';
import 'package:user_app/infrastructure/models/daysModel.dart';
import 'package:user_app/infrastructure/models/orderModel.dart';
import 'package:user_app/infrastructure/services/availableDaysServices.dart';
import 'package:user_app/presentation/elements/appBar.dart';
import 'package:user_app/presentation/elements/appButton.dart';
import 'package:user_app/presentation/elements/custom_snackbar.dart';
import 'package:user_app/presentation/elements/divider.dart';
import 'package:user_app/presentation/elements/dynamicFontSize.dart';
import 'package:user_app/presentation/elements/heigh_sized_box.dart';
import 'package:user_app/presentation/elements/horizontal_sized_box.dart';
import 'package:user_app/presentation/elements/loading_widget.dart';
import 'package:user_app/presentation/views/addressView.dart';
import 'package:user_app/presentation/views/authView/login.dart';
import 'package:user_app/validation/navigation_constant.dart';

class AddAvailableDays extends StatefulWidget {
  final String locationID;
  final String locationName;

  AddAvailableDays(this.locationID, this.locationName);

  @override
  _AddAvailableDaysState createState() => _AddAvailableDaysState();
}

class _AddAvailableDaysState extends State<AddAvailableDays> {
  AddAvailableDaysServices _addAvailableDaysServices =
      AddAvailableDaysServices();

  List<DaysModel> dayList = [
    DaysModel("0", "monday"),
    DaysModel("1", "tuesday"),
    DaysModel("2", "wednesday"),
    DaysModel("3", "thursday"),
    DaysModel("4", "friday"),
    DaysModel("5", "saturday"),
    DaysModel("6", "sunday"),
  ];
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return _getUI(context);
  }

  Widget _getUI(BuildContext context) {
    return StreamProvider.value(
      value: _addAvailableDaysServices.streamTimeSlots(widget.locationID),
      builder: (context, child) {
        return Scaffold(
          appBar: customAppBar(context, text: "available_days", onTap: () {
            Navigator.pop(context);
          }),
          body: context.watch<List<AvailableDaysModel>>() == null
              ? LoadingWidget()
              : _displayUI(context),
        );
      },
    );
  }

  Widget _displayUI(BuildContext context) {
    var selectedLocation = Provider.of<LocationProvider>(context);
    var user = Provider.of<User>(context);
    return Column(
      children: [
        CustomDivider(),
        VerticalSpace(10),
        Expanded(
          child: StreamProvider.value(
            value: _addAvailableDaysServices.streamTimeSlots(widget.locationID),
            builder: (context, child) {
              return context.watch<List<AvailableDaysModel>>() == null
                  ? LoadingWidget()
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount:
                          context.watch<List<AvailableDaysModel>>().length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          // color: Colors.green,
                          onTap: () {
                            if (context
                                    .read<List<AvailableDaysModel>>()[i]
                                    .fromTime !=
                                "N/A") {
                              setIndex(i);
                              selectedLocation.setLocation(LocationDetailsModel(
                                  pickupLocation: widget.locationName,
                                  selectedPickUpDay: context
                                      .read<List<AvailableDaysModel>>()[i]
                                      .day,
                                  selectedPickUpTime:
                                      "${context.read<List<AvailableDaysModel>>()[i].fromTime}" +
                                          "-" +
                                          "${context.read<List<AvailableDaysModel>>()[i].toTime}"));
                            }

                            print("Called");
                          },
                          child: Container(
                            color: getIndex == i
                                ? Color(0x4df9812a)
                                : Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                VerticalSpace(10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: DynamicFontSize(
                                    label: dayList[i].day,
                                    fontSize: 16,
                                    isAlignCenter: false,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                VerticalSpace(15),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      DynamicFontSize(
                                        label: context
                                                    .watch<
                                                        List<
                                                            AvailableDaysModel>>()[
                                                        i]
                                                    .day ==
                                                i.toString()
                                            ? context
                                                .watch<
                                                    List<
                                                        AvailableDaysModel>>()[
                                                    i]
                                                .fromTime
                                            : "N/A",
                                        fontSize: 14,
                                        isAlignCenter: false,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      HorizontalSpace(10),
                                      DynamicFontSize(label: "-", fontSize: 20),
                                      HorizontalSpace(10),
                                      DynamicFontSize(
                                        label: context
                                                    .watch<
                                                        List<
                                                            AvailableDaysModel>>()[
                                                        i]
                                                    .day ==
                                                i.toString()
                                            ? context
                                                .watch<
                                                    List<
                                                        AvailableDaysModel>>()[
                                                    i]
                                                .toTime
                                            : "N/A",
                                        fontSize: 14,
                                        isAlignCenter: false,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                                VerticalSpace(10),
                                CustomDivider(),
                              ],
                            ),
                          ),
                        );
                      });
            },
          ),
        ),
        AppButton(
          text: "Next",
          isDark: true,
          onTap: () {
            if (getIndex == -1) {
              return customFlushBar(context,
                  errorString: ValidationConstant.emptyPickUpTime);
            }

            if (user == null) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginView()));
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddressView()));
            }
          },
        ),
        VerticalSpace(50),
      ],
    );
  }

  void setIndex(int i) {
    selectedIndex = i;
    setState(() {});
  }

  get getIndex => selectedIndex;

  textFieldDecoration(String label, BuildContext context, [String hint]) {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
        borderSide: BorderSide(color: FrontEndConfigs.borderColor));
    return InputDecoration(
        disabledBorder: outlineInputBorder,
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        hintText: hint == null ? '' : hint,
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder);
  }
}
