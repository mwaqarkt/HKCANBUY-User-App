import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '/application/errorStrings.dart';
import '/application/signUpBusinissLogic.dart';
import '/configurations/frontEndConfigs.dart';
import '/infrastructure/models/userModel.dart';
import '/infrastructure/services/authServices.dart';
import '/presentation/elements/appButton.dart';
import '/presentation/elements/authTextField.dart';
import '/presentation/elements/dialog.dart';
import '/presentation/elements/dynamicFontSize.dart';
import '/presentation/elements/heigh_sized_box.dart';
import '/presentation/elements/navigation_dialog.dart';

import 'login.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _contactNumberController = TextEditingController();
  bool isObscure = true;
  var node;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SignUpBusinessLogic signUp = Provider.of<SignUpBusinessLogic>(context);
    node = FocusScope.of(context);
    return
        //  LoadingOverlay(
        //   isLoading: signUp.status == SignUpStatus.Registering,
        //   progressIndicator: LoadingWidget(),
        //   color: FrontEndConfigs.blueTextColor,
        //   child:

        Scaffold(
            body: SafeArea(child: _getUI(context)),
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: [],
            ));
    //   ),
    // );
  }

  Widget _getUI(BuildContext context) {
    AuthServices users = Provider.of<AuthServices>(context);
    SignUpBusinessLogic signUp = Provider.of<SignUpBusinessLogic>(context);
    var user = Provider.of<User>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VerticalSpace(100),
              DynamicFontSize(
                label: "register_here",
                fontSize: 32,
                fontWeight: FontWeight.w600,
                isAlignCenter: false,
                isBold: true,
                color: Colors.black,
              ),
              VerticalSpace(12),
              DynamicFontSize(
                label: "provider_your_details_to_register",
                letterSpacing: 0.4,
                fontSize: 13,
                isAlignCenter: false,
                lineHeight: 1.4,
                fontWeight: FontWeight.w600,
                color: Color(0xff6B6E74),
              ),
              VerticalSpace(36),
              AuthTextField(
                validator: (val) =>
                    val.isEmpty ? "first_name_cannot_be_empty.".tr() : null,
                controller: _firstName,
                label: "FIRST NAME",
                onEditingComplete: () => node.nextFocus(),
              ),
              VerticalSpace(23),
              AuthTextField(
                controller: _lastName,
                validator: (val) =>
                    val.isEmpty ? "last_name_cannot_be_empty.".tr() : null,
                label: "last_name",
                onEditingComplete: () => node.nextFocus(),
              ),
              VerticalSpace(23),
              AuthTextField(
                controller: _contactNumberController,
                validator: (val) =>
                    val.isEmpty ? "contact_number_cannot_be_empty".tr() : null,
                label: "contact_number",
                onEditingComplete: () => node.nextFocus(),
              ),
              VerticalSpace(23),
              AuthTextField(
                controller: _emailController,
                validator: (val) =>
                    val.isEmpty ? "email_cannot_be_empty".tr() : null,
                label: "your_email",
                onEditingComplete: () => node.nextFocus(),
              ),
              VerticalSpace(23),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DynamicFontSize(
                      label: "your_pwd",
                      letterSpacing: 0.5,
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w700),
                  VerticalSpace(5),
                  TextFormField(
                    controller: _pwdController,
                    validator: (val) => val == null || val.isEmpty
                        ? "pwd_cannot_be_empty".tr()
                        : null,
                    onEditingComplete: () => node.nextFocus(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.4,
                        color: Colors.black),
                    obscureText: isObscure,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: !isObscure
                              ? Image.asset(
                                  'assets/images/hide.png',
                                  height: 25,
                                )
                              : Image.asset(
                                  'assets/images/show.png',
                                  height: 25,
                                ),
                          onPressed: () {
                            isObscure = !isObscure;
                            setState(() {});
                          },
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: FrontEndConfigs.borderColor)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: FrontEndConfigs.borderColor)),
                        labelStyle: TextStyle(
                            letterSpacing: 1,
                            fontFamily: "Inter",
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              VerticalSpace(47),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton(
                    text: "register_now",
                    isDark: true,
                    onTap: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _signUpUser(context: context, signUp: signUp, user: user);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      // builder: (context) => CustomBottomNavbar()));
                    },
                  ),
                ],
              ),
              VerticalSpace(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DynamicFontSize(
                    label: "have_an_account",
                    fontFamily: "Inter",
                    color: Theme.of(context).textTheme.headline4!.color,
                    letterSpacing: -0.4,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    isBold: true,
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginView()));
                    },
                    child: DynamicFontSize(
                      label: "login",
                      letterSpacing: -0.4,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter",
                      isUnderline: true,
                      color: Color(0xff209CEE),
                      isBold: true,
                    ),
                  ),
                ],
              ),
              VerticalSpace(40),
            ],
          ),
        ),
      ),
    );
  }

  _signUpUser(
      {required BuildContext context,
      required SignUpBusinessLogic signUp,
      required User user}) {
    signUp
        .registerNewUser(
            email: _emailController.text,
            password: _pwdController.text,
            userModel: UserModel(
                firstName: _firstName.text,
                lastName: _lastName.text,
                contactNumber: _contactNumberController.text,
                type: "customers",
                email: _emailController.text),
            context: context,
            user: user)
        .then((value) {
      if (signUp.status == SignUpStatus.Registered) {
        showNavigationDialog(context,
            message: "thanks_for_register",
            buttonText: "go_to_login", navigation: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginView()));
        }, secondButtonText: "", showSecondButton: false);
      } else if (signUp.status == SignUpStatus.Failed) {
        showErrorDialog(context,
            message: Provider.of<ErrorString>(context, listen: false)
                .getErrorString());
      }
    });
  }
}
