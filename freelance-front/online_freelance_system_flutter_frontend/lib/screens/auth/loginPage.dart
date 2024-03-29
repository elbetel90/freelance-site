import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_freelance_system_flutter_frontend/bloc/auth_bloc/authBloc.dart';
import 'package:online_freelance_system_flutter_frontend/bloc/auth_bloc/authEvent.dart';
import 'package:online_freelance_system_flutter_frontend/bloc/auth_bloc/authState.dart';
import 'package:online_freelance_system_flutter_frontend/models/User.dart';
import 'package:online_freelance_system_flutter_frontend/screens/widgets/customRoundButton.dart';
import 'package:online_freelance_system_flutter_frontend/screens/widgets/customRoundFormField.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';
import 'package:online_freelance_system_flutter_frontend/utils/routeNames.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _user = {};
  static String errorText = "";
  static IconData? warnIcon;
  static FormState _formState = FormState();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_navBar(context), _formBody(context), _footer(context)],
          ),
        ),
      ),
    );
  }

  Widget _navBar(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.symmetric(
                horizontal: BorderSide(width: 0.5, color: lightGrey))),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 45, vertical: 6),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(18)),
                        child: Center(
                            child: Text(
                          "E",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white),
                        )),
                      ),
                      SizedBox(width: 16),
                      Text(
                        "Elance",
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ])));
  }

  Widget _footer(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      width: MediaQuery.of(context).size.width,
      color: kPrimaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "© 2015 - 2021 ETWork Global Inc.",
            style: whitenavButtonTextStyle,
          ),
          Text(
            "Terms of Service",
            style: whitenavButtonTextStyle,
          ),
          Text(
            "Privacy And Policy",
            style: whitenavButtonTextStyle,
          ),
          Text(
            "Accesseblity",
            style: whitenavButtonTextStyle,
          )
        ],
      ),
    );
  }

  Widget _formBody(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      print(state.isAuthenticated);
      if (state.isAuthenticated) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(context, homepageroute);
        });
      } else if (state.isFailed) {
        // Navigator.pushNamed(context, loginpageroute);
      }
      return Container(
        width: MediaQuery.of(context).size.width / 3,
        margin: EdgeInsets.all(60),
        padding: EdgeInsets.all(80),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: lightGrey, width: 2.0),
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          children: [
            Container(
              child: Text(
                "Login In Etwork",
                style: greenNavButtonTextStyle.copyWith(color: kPrimaryColor),
              ),
            ),
            Container(
              child: Row(
                children: [
                  Icon(
                    warnIcon,
                    color: kSecondaryColor,
                  ),
                  Text(
                    errorText,
                    style: greenNavButtonTextStyle.copyWith(
                        color: kSecondaryColor),
                  ),
                ],
              ),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomRoundFormField(
                        isObscure: false,
                        onSaved: (value) {
                          setState(() {
                            this._user['email'] = value.toString();
                            print("Email = " + this._user['email']);
                          });
                        },
                        hintText: "Email",
                        prefixIconData: Icons.person),
                    CustomRoundFormField(
                      isObscure: false,
                      onSaved: (value) {
                        setState(() {
                          this._user['password'] = value.toString();
                          // print("Password = " + this._user['user']);
                        });
                      },
                      hintText: "Password",
                      prefixIconData: Icons.lock,
                      checkTitle: "secondary",
                      suffixIconData: Icons.remove_red_eye,
                    ),
                    CustomRoundButton(
                      onPressed: () {
                        final form = _formKey.currentState;
                        print(this._user['email']);
                        if (this._user['email'] == null) {
                          print("Email Null");
                          setState(() {
                            warnIcon = Icons.info;
                            errorText = "Please Fill The Email Form";
                          });
                        } else if (this._user['password'] == null) {
                          print("Password Null");
                          setState(() {
                            warnIcon = Icons.info;

                            errorText = "Please Fill The Password Form";
                          });
                        } else {
                          if (form!.validate()) {
                            form.save();
                            print(this._user['email']);

                            final AuthEvent event = AuthLogin(
                                this._user["email"], this._user["password"]);
                            BlocProvider.of<AuthBloc>(context).add(event);
                          }
                        }
                      },
                      title: "Login",
                      checktitle: "primary",
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text('or',
                          style:
                              TextStyle(decoration: TextDecoration.overline)),
                    ),
                    CustomRoundButton(
                      onPressed: () {},
                      title: "Continue With Google",
                      iconData: AntIcons.google,
                      checktitle: "blue",
                    ),
                    CustomRoundButton(
                      onPressed: () {},
                      checktitle: "black",
                      title: "Continue With Apple",
                      iconData: AntIcons.apple,
                    ),
                  ],
                )),
            Divider(),
            Text(
              "Don't Have An Account ?",
              style: greenNavButtonTextStyle,
            ),
            CustomRoundButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                title: "Sign Up",
                checktitle: "secondary")
          ],
        ),
      );
    });
  }
}
