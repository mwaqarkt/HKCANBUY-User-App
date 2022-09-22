import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
// import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import '/application/errorStrings.dart';
import '/configurations/enums.dart';
import '/infrastructure/services/authServices.dart';
import '/presentation/elements/appButton.dart';
import '/presentation/elements/authTextField.dart';
import '/presentation/elements/dialog.dart';
import '/presentation/elements/dynamicFontSize.dart';
import '/presentation/elements/heigh_sized_box.dart';
import '/presentation/elements/navigation_dialog.dart';
import '/presentation/views/authView/login.dart';

class ForgotPasswordView extends StatefulWidget {
  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  AuthServices _authServices = AuthServices();
  bool isObscure = true;
  final _formKey = GlobalKey<FormState>();
  var node;
  TextEditingController _emailController = TextEditingController();
  // late ProgressDialog pr;
  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);
    // pr = ProgressDialog(context, isDismissible: false);
    return Scaffold(
      body: SafeArea(child: _getUI(context)),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DynamicFontSize(
                label: "remember_pwd",
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
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => SignUpView()));
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
    );
  }

  Widget _getUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VerticalSpace(100),
              DynamicFontSize(
                label: "request_pwd_reset",
                fontSize: 32,
                fontWeight: FontWeight.w600,
                isAlignCenter: false,
                isBold: true,
                color: Colors.black,
              ),
              VerticalSpace(12),
              DynamicFontSize(
                label: "provide_reg_email",
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
                validator: (val) =>
                    val.isEmpty ? "email_cannot_be_empty".tr() : null,
                label: "your_email",
                onEditingComplete: () => node.nextFocus(),
              ),
              VerticalSpace(47),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton(
                    isDark: true,
                    text: "send_recovery_link",
                    onTap: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      // await pr.show();
                      _forgotPassword(context);
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

  _forgotPassword(BuildContext context) {
    AuthServices _services = Provider.of<AuthServices>(context, listen: false);
    _services
        .forgotPassword(context, email: _emailController.text)
        .then((val) async {
      // await pr.hide();
      if (_services.status == Status.Authenticated) {
        showNavigationDialog(context,
            message:
                "An email with password reset link has been sent to your email inbox",
            buttonText: "Okay", navigation: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginView()));
        }, secondButtonText: "", showSecondButton: false);
      } else {
        showErrorDialog(context,
            message: Provider.of<ErrorString>(context, listen: false)
                .getErrorString());
      }
    });
  }
}
