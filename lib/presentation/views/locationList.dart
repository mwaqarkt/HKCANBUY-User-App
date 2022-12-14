import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/infrastructure/models/adddressModel.dart';
import 'package:user_app/infrastructure/services/addressServices.dart';
import 'package:user_app/presentation/elements/addressTile.dart';
import 'package:user_app/presentation/elements/appBar.dart';
import 'package:user_app/presentation/elements/divider.dart';
import 'package:user_app/presentation/elements/heigh_sized_box.dart';
import 'package:user_app/presentation/elements/loading_widget.dart';
import 'package:user_app/presentation/elements/noData.dart';
import 'package:user_app/presentation/views/homePage.dart';

class LocationListView extends StatefulWidget {
  @override
  _LocationListViewState createState() => _LocationListViewState();
}

class _LocationListViewState extends State<LocationListView> {
  AddressServices _addressServices = AddressServices();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      },
      child: Scaffold(
        appBar: customAppBar(context, text: "locations", onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        }),
        body: _getUI(context),
      ),
    );
  }

  Widget _getUI(BuildContext context) {
    return Column(
      children: [
        CustomDivider(),
        VerticalSpace(15),
        Expanded(
          child: StreamProvider.value(
            value: _addressServices.streamAddress(),
            builder: (context, child) {
              return context.watch<List<AddressModel>>() == null
                  ? Container(
                      height: MediaQuery.of(context).size.height - 150,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(child: LoadingWidget()),
                        ],
                      ),
                    )
                  : context.watch<List<AddressModel>>().length != 0
                      ? ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: context.watch<List<AddressModel>>().length,
                          itemBuilder: (context, i) {
                            return AddressTile(
                                addressModel:
                                    context.watch<List<AddressModel>>()[i]);
                            // title: Text(
                            //     .address),
                            // onTap: () {
                            //   AddressModel _model =
                            //       context.read<List<AddressModel>>()[i];
                          })
                      : NoData();
            },
          ),
        )
      ],
    );
  }
}
