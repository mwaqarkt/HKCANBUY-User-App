import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
// import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import '/application/userDetails.dart';
import '/configurations/backEdnConfigs.dart';
import '/infrastructure/models/orderModel.dart';
import '/infrastructure/models/userModel.dart';
import '/presentation/elements/appBar.dart';
import '/presentation/elements/appButton.dart';
import '/presentation/elements/detail_text_field.dart';
import '/presentation/elements/divider.dart';
import '/presentation/elements/heigh_sized_box.dart';
import '/presentation/elements/loading_widget.dart';
import '/presentation/views/orderReview.dart';
import '/validation/navigation_constant.dart';
import '/validation/validation_handler.dart';

class AddressView extends StatelessWidget {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final LocalStorage storage = new LocalStorage(BackEndConfigs.loginLocalDB);
  bool initialized = false;
  UserModel userModel = UserModel();
  // ProgressDialog? pr;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: FutureBuilder(
                future: storage.ready,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!initialized) {
                    var items =
                        storage.getItem(BackEndConfigs.userDetailsLocalStorage);

                    if (items != null) {
                      print(items);
                      userModel = UserModel(
                        firstName: items['firstName'],
                        lastName: items['lastName'],
                        docID: items['docID'],
                        contactNumber: items['contactNumber'],
                        email: items['email'],
                      );
                    }
                    _firstNameController =
                        TextEditingController(text: userModel.firstName);
                    _lastNameController =
                        TextEditingController(text: userModel.lastName);
                    _emailController =
                        TextEditingController(text: userModel.email);
                    _phoneNumberController =
                        TextEditingController(text: userModel.contactNumber);
                    initialized = true;
                  }
                  return snapshot.data == null
                      ? LoadingWidget()
                      : _getUI(context);
                })));
  }

  Widget _getUI(BuildContext context) {
    var userDetails = Provider.of<UserDetailsProvider>(context);
    var user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: customAppBar(context, text: "Personal Details", onTap: () {
        Navigator.pop(context);
      }),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomDivider(),
            VerticalSpace(20),
            DetailTextField(
              data: _firstNameController,
              label: "first_name".tr(),
              validator: (val) => ValidationHandler.validateInput(
                  returnString: ValidationConstant.emptyFirstName,
                  inputValue: val!),
            ),
            DetailTextField(
              data: _lastNameController,
              label: "last_name".tr(),
              validator: (val) => ValidationHandler.validateInput(
                  returnString: ValidationConstant.emptyLastName,
                  inputValue: val!),
            ),
            DetailTextField(
              data: _emailController,
              label: "email".tr(),
              keyBoardType: TextInputType.emailAddress,
              validator: (val) => ValidationHandler.validateInput(
                  returnString: ValidationConstant.emptyEmail,
                  inputValue: val!),
            ),
            DetailTextField(
              data: _phoneNumberController,
              label: "contact_number".tr(),
              keyBoardType: TextInputType.number,
              validator: (val) => ValidationHandler.validateInput(
                  returnString: ValidationConstant.emptyContactNumber,
                  inputValue: val!),
            ),
            VerticalSpace(20),
            AppButton(
              onTap: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                userDetails.addUserDetails(UserDetailsModel(
                    firstName: _firstNameController.text,
                    uid: user.uid,
                    lastName: _lastNameController.text,
                    email: _emailController.text,
                    contactNumber: _phoneNumberController.text));
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrderDetails()));
              },
              text: "Next",
              isDark: true,
            )
          ],
        ),
      ),
    );
  }
}
