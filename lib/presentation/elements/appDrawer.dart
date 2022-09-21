import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:user_app/configurations/backEdnConfigs.dart';
import 'package:user_app/configurations/frontEndConfigs.dart';
import 'package:user_app/infrastructure/models/userModel.dart';
import 'package:user_app/infrastructure/services/authServices.dart';
import 'package:user_app/presentation/views/authView/login.dart';
import 'package:user_app/presentation/views/cart.dart';
import 'package:user_app/presentation/views/contact_us.dart';
import 'package:user_app/presentation/views/getMyOrders.dart';
import 'package:user_app/presentation/views/homePage.dart';
import 'package:user_app/presentation/views/viewCategories.dart';

import 'heigh_sized_box.dart';

class AppDrawer extends StatelessWidget {
  final LocalStorage storage = new LocalStorage(BackEndConfigs.loginLocalDB);
  bool initialized = false;
  UserModel userModel = UserModel();
  AuthServices _authServices = AuthServices.instance();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: storage.ready,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!initialized) {
            var items = storage.getItem(BackEndConfigs.userDetailsLocalStorage);

            if (items != null) {
              userModel = UserModel(
                firstName: items['firstName'],
                lastName: items['lastName'],
                email: items['email'],
              );
            }

            initialized = true;
          }
          return snapshot.data == null
              ? CircularProgressIndicator()
              : _getUI(context);
        });
  }

  Widget _getUI(BuildContext context) {
    var user = Provider.of<User>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          VerticalSpace(10),
          _createDrawerItem(
              icon: Icons.dashboard,
              text: 'dashboard',
              onTap: () {
                Navigator.pop(context);
              }),
          Divider(),
          _createDrawerItem(
              icon: Icons.category,
              text: 'categories',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ViewCategories()));
              }),
          if (user != null) Divider(),
          if (user != null)
            _createDrawerItem(
                icon: Icons.fiber_smart_record,
                text: 'my_orders',
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UsersOrders()));
                }),
          if (user != null) Divider(),
          if (user != null)
            _createDrawerItem(
                icon: Icons.shopping_cart,
                text: 'my_cart',
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartView()));
                }),
          if (user != null) Divider(),
          if (user != null)
            _createDrawerItem(
                icon: Icons.chat,
                text: 'chats',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Messages(
                                receiverID: "UdPCYhOQgGeLyMNCs7VpDmanRyH3",
                                productName: "",
                                productPrice: "".toString(),
                                productImage: "",
                                productID: "",
                              )));
                }),
          if (user == null) Divider(),
          if (user == null)
            _createDrawerItem(
                icon: Icons.person,
                text: 'login',
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginView()));
                }),
          _createDrawerItem(
              icon: Icons.language,
              text: 'change_language',
              onTap: () {
                context.locale = context.locale != Locale('en', 'US')
                    ? Locale('en', 'US')
                    : Locale('zh', 'CN');
              }),
          // if (user != null) Divider(),
          // if (user != null)
          //   _createDrawerItem(
          //       icon: Icons.exit_to_app_outlined,
          //       text: 'my_cart',
          //       onTap: () async {
          //         Navigator.pushAndRemoveUntil(
          //             context,
          //             MaterialPageRoute(builder: (context) => CartView()),
          //             (route) => false);
          //         _authServices.signOut();
          //       }),
          if (user != null) Divider(),
          if (user != null)
            _createDrawerItem(
                icon: Icons.exit_to_app_outlined,
                text: 'sign_out',
                onTap: () async {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false);
                  _authServices.signOut();
                }),
          Divider(),
          _createDrawerItem(
              icon: Icons.bug_report, text: 'report_an_issue', onTap: () {}),
          ListTile(
            title: Text('1.0.0'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  //
  Widget _createHeader() {
    return Container(
      height: 240,
      child: DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(color: FrontEndConfigs.appBaseColor),
        child: Column(
          children: [
            VerticalSpace(60),
            Container(
              height: 115,
              width: 115,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/logo.jpg')),
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: Colors.white)),
            ),
            VerticalSpace(10),
            _getHeaderText(
              userModel.email,
            ),
          ],
        ),
      ),
    );
  }

  _getHeaderText(String text) {
    return Text(
      text ?? "N/A",
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
    );
  }

  Widget _createDrawerItem(
      {IconData icon,
      String text,
      GestureTapCallback onTap,
      String iconString}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          icon == null
              ? ImageIcon(
                  AssetImage(iconString),
                  color: Colors.black,
                )
              : Icon(
                  icon,
                  color: Colors.black,
                  size: 16,
                ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text).tr(),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
