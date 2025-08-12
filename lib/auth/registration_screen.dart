import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raya_mobile/app_dashboard/dashboard.dart';
import 'package:raya_mobile/bloc/bottom_tab/bloc.dart';
import 'package:raya_mobile/bloc/bottom_tab/events.dart';
import 'package:raya_mobile/bloc/bottom_tab/states.dart';
import 'package:raya_mobile/repo/users_repo.dart';
import 'package:raya_mobile/util/AppColorPalette.dart';
import 'package:raya_mobile/util/utils.dart';
import 'package:raya_mobile/widget/app_fonts.dart';
import 'package:raya_mobile/widget/app_input_field.dart';
import 'package:raya_mobile/widget/app_snackbar.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _rcController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();

  String? email;
  String? phone;
  String? name;
  String? refCode;

  String? eEmail;
  String? ePhone;
  String? eName;

  final UsersRepo usersRepo = UsersRepo();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void registerUser() {
    int errors = 0;
    if (_userNameController.text.isEmpty) {
      displaySnackBar("Please enter Name", context);
      return;
    } else if (_mailController.text.isNotEmpty &&
        !emailValidatorRegExp.hasMatch(_mailController.text)) {
      displaySnackBar("PLease enter correct mail id", context);
      return;
    } else {
      registerUserInfo();
    }
  }

  void registerUserInfo() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final osType = Platform.isAndroid ? "ANDROID" : "IOS";

    final result = await usersRepo.registerUser(
        _phoneController.text, _userNameController.text, _mailController.text);
    if (result.isSuccess) {
      saveUser(result.data!.result!);
      Navigator.of(context).popUntil(ModalRoute.withName('/'));
      context.read<BottomTabBloc>().add(BottomTabChangeEvent(tab: BottomTab.radio));
    } else {
      displaySnackBar(
          result.error?.message ?? 'Unable to register user. Please try again.',
          context);
    }

    // UserService(appDioClient()).registerUser(RegisterRequest(_userNameController.text.trim(), "${_phoneController.text.trim()}@eatprotien.in", reverseStringUsingCodeUnits(_phoneController.text.trim()), "5", "ACTIVE", _phoneController.text.trim(),referCode?.trim(),id?.trim(),city,"${lat}","${lng}", osType))
    //     .then((value) => checkResponse(value))
    // //.onError((error, stackTrace) => checkError(error.runtimeType,error!))
    //     .catchError((Object obj) {
    //   checkError(runtimeType,obj);
    // });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    phone = args?['phone'] as String? ?? '';
    _phoneController.text = phone ?? '';

    return Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //       image: AssetImage('assets/register.png'), fit: BoxFit.cover),
          // )
          // ,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: getAppRegularText("Signup", 18),
            ),
            body: Stack(
              children: [
                Container(
                  height: 140,
                  child: Center(child: Image.asset('images/raya_logo.png')),
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 25, right: 25),
                          child: Column(
                            children: [
                              appDisabledInputField("Phone", "Phone Number",
                                  _phoneController, TextInputType.number),
                              const SizedBox(
                                height: 20,
                              ),
                              appInputFieldError(
                                  "Name",
                                  "Full Name *",
                                  _userNameController,
                                  TextInputType.name,
                                  eName),
                              const SizedBox(
                                height: 20,
                              ),
                              appInputFieldMail("Email", "e-Mail ID",
                                  _mailController, TextInputType.emailAddress),
                              const SizedBox(
                                height: 20,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    '',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 27,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor:
                                        AppColorPalette.appColorGreen,
                                    child: IconButton(
                                        color: Colors.white,
                                        onPressed: () {
                                          registerUser();
                                        },
                                        icon: const Icon(
                                          Icons.arrow_forward,
                                        )),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
