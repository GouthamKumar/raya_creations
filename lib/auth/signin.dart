import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:raya_mobile/app/models/user_response.dart';
import 'package:raya_mobile/app_dashboard/dashboard.dart';
import 'package:raya_mobile/bloc/bottom_tab/bloc.dart';
import 'package:raya_mobile/bloc/bottom_tab/events.dart';
import 'package:raya_mobile/bloc/bottom_tab/states.dart';
import 'package:raya_mobile/repo/users_repo.dart';
import 'package:raya_mobile/splash/splash_screen.dart';
import 'package:raya_mobile/util/AppColorPalette.dart';
import 'package:raya_mobile/util/app_local_data.dart';
import 'package:raya_mobile/util/utils.dart';
import 'package:raya_mobile/widget/app_fonts.dart';
import 'package:raya_mobile/widget/app_snackbar.dart';

enum ErrorAnimationType { shake, clear }

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  String? phoneNumber;
  late String phoneNumberRegister;
  TextEditingController otpEditingController = TextEditingController();
  String? _verificationId;
  int? forceResendingToken;
  bool showOtpScreen = false;
  bool showRegisterScreen = false;
  late StreamController<ErrorAnimationType> errorController;
  bool loading = false;
  UserResponse? userResponse;
  String testPhone = "9739132303";
  final UsersRepo usersRepo = UsersRepo();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  void verifyPhoneNumber() async {
    final result = await usersRepo.checkUse(phoneNumberRegister);
    if (result.data?.status == true) {
      processNext(result.data);
    } else {
      processOtp(true);
    }
  }

  processNext(UserResponse? value) {
    userResponse = value;
    processOtp(false);
  }

  void processOtp(bool isNewCustomer) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      if (phoneNumberRegister == testPhone) {
        showOtpScreen = true;
        otpEditingController.text = "123456";
        await Future.delayed(const Duration(milliseconds: 3000));
        saveResp();
      } else {
        verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
          //  User? user;
          bool error = false;
          try {
            // user=(await firebaseAuth.signInWithCredential(phoneAuthCredential)).user!;
            await firebaseAuth
                .signInWithCredential(phoneAuthCredential)
                .then((value) => {
                      if (value != null)
                        {
                          debugPrint("Error In OTP $value"),
                          //here you can store user data in backend
                          otpEditingController.text =
                              phoneAuthCredential.smsCode!
                          // isNewCustomer
                          //     ? Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => MyRegister(
                          //             phoneNumberRegister:
                          //             phoneNumberRegister)))
                          //     : saveUser()
                        }
                    });
          } catch (e) {
            debugPrint("Error In OTP $e");
          }
        }

        verificationFailed(FirebaseAuthException authException) {
          debugPrint("Wrong OTP. Please enter Correct OTP.$authException");
        }

        codeSent(String? verificationId, [int? forceResendingToken]) async {
          debugPrint('Please check your phone for the verification code.');
          this.forceResendingToken = forceResendingToken;
          _verificationId = verificationId;
        }

        codeAutoRetrievalTimeout(String verificationId) {
          _verificationId = verificationId;
        }

        try {
          await firebaseAuth.verifyPhoneNumber(
              phoneNumber: phoneNumber!,
              timeout: const Duration(seconds: 5),
              forceResendingToken: forceResendingToken ?? null,
              verificationCompleted: verificationCompleted,
              verificationFailed: verificationFailed,
              codeSent: codeSent,
              codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
          showOtpScreen = true;
        } catch (e) {
          debugPrint("Failed to Verify Phone Number: $e");
          showOtpScreen = false;
        }
        setState(() {
          loading = false;
        });
      }
    }
  }

  void signInWithPhoneNumber() async {
    bool error = false;
    User? user;
    AuthCredential credential;
    setState(() {
      loading = true;
    });
    try {
      credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otpEditingController.text,
      );
      user = (await firebaseAuth.signInWithCredential(credential)).user!;
    } catch (e) {
      error = true;
      displaySnackBar("Failed to sign in: Wrong OTP.", context);
    }
    if (!error && user != null) {
      userResponse != null
          ? saveResp()
          : Navigator.pushNamed(context, '/register',
              arguments: {'phone': phoneNumberRegister});
    }
    setState(() {
      loading = false;
    });
  }

  void saveResp() {
    saveUser(userResponse!.result!);
    context
        .read<BottomTabBloc>()
        .add(BottomTabChangeEvent(tab: BottomTab.radio));
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: showOtpScreen ? otpUI() : loginUI(),
    );
  }

  Widget loginUI() {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  FittedBox(
                    fit: BoxFit.fill,
                    child: Image.asset(
                      "images/raya_logo.png",
                      height: 300,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 1, bottom: 1),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: InternationalPhoneNumberInput(
                        cursorColor: Colors.black,
                        onInputChanged: (PhoneNumber number) {
                          phoneNumber = number.phoneNumber;
                          phoneNumberRegister = number.parseNumber();
                        },
                        onInputValidated: (bool value) {
                          print(value);
                        },
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.DIALOG,
                        ),
                        spaceBetweenSelectorAndTextField: 0,
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: const TextStyle(color: Colors.black),
                        initialValue: PhoneNumber(isoCode: 'US'),
                        formatInput: false,
                        keyboardType: TextInputType.phone,
                        inputBorder: InputBorder.none,
                        maxLength: 10,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () => verifyPhoneNumber(),
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: AppColorPalette.appPrimary,
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget otpUI() {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  FittedBox(
                    fit: BoxFit.fill,
                    child: Image.asset(
                      "images/raya_logo.png",
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    getAppRegularTextColor(
                        "You'll receive an OTP on", 16, Colors.black),
                    getAppBoldTextSizeColor("$phoneNumber", 16, Colors.black),
                    /*Text.rich(
                    TextSpan(
                        text: 'number : ',
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0,),
                        children: [
                          TextSpan(
                            text: phoneNumber,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ]
                    ),
                  ),*/
                    const SizedBox(
                      height: 30,
                    ),
                    // PinCodeTextField(
                    //   appContext: context,
                    //   pastedTextStyle: const TextStyle(
                    //     color: AppColorPalette.appSecondaryColor,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    //   length: 6,
                    //   obscureText: false,
                    //   blinkWhenObscuring: true,
                    //   animationType: AnimationType.fade,
                    //   validator: (v) {
                    //     if (v!.length < 6) {
                    //       return "Not Valid OTP";
                    //     } else {
                    //       return null;
                    //     }
                    //   },
                    //   pinTheme: PinTheme(
                    //     shape: PinCodeFieldShape.underline,
                    //     // borderRadius: BorderRadius.circular(10),
                    //     borderWidth: 0.5,
                    //     fieldHeight: 40,
                    //     fieldWidth: 40,
                    //     activeFillColor: Colors.white,
                    //     inactiveFillColor: Colors.white,
                    //     inactiveColor: AppColorPalette.appPrimary,
                    //     selectedFillColor: Colors.white,
                    //     activeColor: AppColorPalette.appPrimary,
                    //     selectedColor: AppColorPalette.appPrimary,
                    //   ),
                    //   cursorColor: Colors.black,
                    //   animationDuration: const Duration(milliseconds: 50),
                    //   enableActiveFill: true,
                    //   // errorAnimationController: errorController,
                    //   controller: otpEditingController,
                    //   keyboardType: TextInputType.number,
                    //   boxShadows: const [
                    //     BoxShadow(
                    //       offset: Offset(0, 1),
                    //       color: Colors.black12,
                    //       blurRadius: 2,
                    //     )
                    //   ],
                    //   onCompleted: (v) {
                    //     debugPrint("Completed");
                    //   },
                    //   // onTap: () {
                    //   //   print("Pressed");
                    //   // },
                    //   onChanged: (value) {
                    //     debugPrint(value);
                    //   },
                    //   beforeTextPaste: (text) {
                    //     debugPrint("Allowing to paste $text");
                    //     //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //     //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    //     return true;
                    //   },
                    // ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: otpEditingController,
                        textAlign: TextAlign.center,
                        maxLength: 6,

                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () => verifyPhoneNumber(),
                        child: const Text(
                          'Code not received? Resend Code',
                          style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 0.688,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () => {
                        if (otpEditingController.text.length == 6)
                          {
                            signInWithPhoneNumber()
                            // if (phoneNumberRegister == testPhone)
                            //   {
                            //     // saveUser()
                            //   }
                            // else
                            //   {signInWithPhoneNumber()}
                          }
                        else if (otpEditingController.text.length < 6)
                          {displaySnackBar("Enter complete otp", context)}
                      },
                      child: !loading
                          ? Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: AppColorPalette.appPrimary,
                              ),
                              child: const Text(
                                'Verify & Continue',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
