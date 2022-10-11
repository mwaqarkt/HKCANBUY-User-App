import 'dart:developer';

import 'package:flutter/material.dart';
import '/infrastructure/models/adddressModel.dart';
import '/presentation/views/addAvailableDays.dart';

import 'dynamicFontSize.dart';

class AddressTile extends StatefulWidget {
  final AddressModel addressModel;

  const AddressTile({
    Key? key,
    required this.addressModel,
  }) : super(key: key);

  @override
  _AddressTileState createState() => _AddressTileState();
}

class _AddressTileState extends State<AddressTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
          child: ListTile(
              minLeadingWidth: 0,
              horizontalTitleGap: 10,
              leading: _buildLeading(Icons.location_on_sharp, context),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: DynamicFontSize(
                      isAlignCenter: false,
                      label: widget.addressModel.address!,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              subtitle: DynamicFontSize(
                isAlignCenter: false,
                label: widget.addressModel.description!,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                ),
                onPressed: () {
                  log(widget.addressModel.addressID!);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddAvailableDays(
                              widget.addressModel.addressID!,
                              widget.addressModel.address!)));
                },
              )),
        ),
      ),
    );
  }

  Widget _buildLeading(IconData icon, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).primaryColor),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            )),
      ],
    );
  }
}
