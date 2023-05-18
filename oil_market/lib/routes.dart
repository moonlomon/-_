import 'package:flutter/cupertino.dart';
import 'package:oil_market/screens/cart/cart_screen.dart';
import 'package:oil_market/screens/complete_profile/complete_profile_screen.dart';
import 'package:oil_market/screens/details/details_screen.dart';
import 'package:oil_market/screens/forgot_password/forgot_password_screen.dart';
import 'package:oil_market/screens/home/home_screen.dart';
import 'package:oil_market/screens/login_success/login_success_screen.dart';
import 'package:oil_market/screens/otp/otp_screen.dart';
import 'package:oil_market/screens/profile/profile_screen.dart';
import 'package:oil_market/screens/schadule/scadule_screen.dart';
import 'package:oil_market/screens/sign_in/sign_in_screen.dart';
import 'package:oil_market/screens/sign_up/sign_up_screen.dart';
import 'package:path/path.dart';

final Map<String, WidgetBuilder> routes = {
  SignInScreen.routeName: (context) => SignInScreen(),
  SchaduleScreen.routeName: (context) => SchaduleScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
};