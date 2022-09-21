import 'package:flutter/material.dart';
import 'package:user_app/infrastructure/models/adddressModel.dart';

import 'dynamicFontSize.dart';

class ProductAddressView extends StatefulWidget {
  final AddressModel addressModel;
  final VoidCallback onPressed;

  const ProductAddressView({
    Key key,
    this.addressModel,
    this.onPressed,
  }) : super(key: key);

  @override
  _ProductAddressViewState createState() => _ProductAddressViewState();
}

class _ProductAddressViewState extends State<ProductAddressView> {
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
                      label: widget.addressModel.address,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              subtitle: DynamicFontSize(
                isAlignCenter: false,
                label: widget.addressModel.description,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
                onPressed: () => widget.onPressed(),
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
