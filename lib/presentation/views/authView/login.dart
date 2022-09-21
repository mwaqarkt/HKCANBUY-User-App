import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:user_app/application/errorStrings.dart';
import 'package:user_app/application/loginBusinessLogic.dart';
import 'package:user_app/configurations/enums.dart';
import 'package:user_app/configurations/frontEndConfigs.dart';
import 'package:user_app/infrastructure/services/authServices.dart';
import 'package:user_app/presentation/elements/appButton.dart';
import 'package:user_app/presentation/elements/authTextField.dart';
import 'package:user_app/presentation/elements/dialog.dart';
import 'package:user_app/presentation/elements/dynamicFontSize.dart';
import 'package:user_app/presentation/elements/heigh_sized_box.dart';
import 'package:user_app/presentation/elements/loading_widget.dart';
import 'package:user_app/presentation/views/authView/signUpView.dart';
import 'package:user_app/presentation/views/homePage.dart';

import 'forgotPasswordView.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool isObscure = true;
  LoginBusinessLogic data = LoginBusinessLogic();
  final _formKey = GlobalKey<FormState>();
  var node;

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthServices>(context);
    return LoadingOverlay(
      isLoading: auth.status == Status.Authenticating,
      progressIndicator: LoadingWidget(),
      color: FrontEndConfigs.blueTextColor,
      child: Scaffold(
        body: SafeArea(child: _getUI(context)),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordView()));
              },
              child: DynamicFontSize(
                label: "forgot_your_pwd",
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.headline4.color,
                letterSpacing: -0.4,
                fontFamily: "Inter",
                isBold: true,
              ),
            ),
            VerticalSpace(13),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DynamicFontSize(
                  label: "dont_have_an_account",
                  fontFamily: "Inter",
                  color: Theme.of(context).textTheme.headline4.color,
                  letterSpacing: -0.4,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  isBold: true,
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpView()));
                  },
                  child: DynamicFontSize(
                    label: "sign_up",
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
    );
  }

  Widget _getUI(BuildContext context) {
    var auth = Provider.of<AuthServices>(context);
    node = FocusScope.of(context);
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VerticalSpace(100),
              DynamicFontSize(
                label: "login",
                fontSize: 32,
                fontWeight: FontWeight.w600,
                isAlignCenter: false,
                isBold: true,
                color: Colors.black,
              ),
              VerticalSpace(12),
              DynamicFontSize(
                label: "user_your_email_and_pwd",
                letterSpacing: 0.4,
                fontSize: 13,
                isAlignCenter: false,
                lineHeight: 1.4,
                fontWeight: FontWeight.w600,
                color: Color(0xff6B6E74),
              ),
              VerticalSpace(36),
              AuthTextField(
                controller: _emailController,
                label: "your_email",
                validator: (val) =>
                    val.isEmpty ? "email_cannot_be_empty".tr() : null,
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
                    onEditingComplete: () => node.nextFocus(),
                    validator: (val) =>
                        val.isEmpty ? "pwd_cannot_be_empty".tr() : null,
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
                    text: "login",
                    isDark: true,
                    onTap: () {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                      loginUser(
                          context: context,
                          data: data,
                          email: _emailController.text,
                          auth: auth,
                          password: _pwdController.text);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  loginUser(
      {@required BuildContext context,
      @required LoginBusinessLogic data,
      @required String email,
      @required AuthServices auth,
      @required String password}) {
    data
        .loginUserLogic(
      context,
      email: email,
      password: password,
    )
        .then((val) async {
      if (auth.status == Status.Authenticated) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => HomePage()), (_) => false);
      } else {
        showErrorDialog(context,
            message: Provider.of<ErrorString>(context, listen: false)
                .getErrorString());
      }
    });
  }
}
