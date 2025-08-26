import 'package:flutter/material.dart';
import 'package:raya_mobile/util/AppColorPalette.dart';
import 'package:raya_mobile/util/app_local_data.dart';
import 'package:raya_mobile/widget/app_fonts.dart';
import 'package:raya_mobile/widget/app_input_field.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final userNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
  }

  void updateUI() async{
    final name = await savedUserName();
    final phone = await savedUserPhone();
    final email = await savedUserMail();
    setState(() {
      userNameController.text = name ?? '';
      phoneNumberController.text = phone ?? '';
      emailController.text = email ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorPalette.appSecondaryColor,
      appBar: AppBar(
        backgroundColor: AppColorPalette.appSecondaryColor,
        title: Image.asset(
          'images/appbar_logo_white.png',
          fit: BoxFit.fill,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(children: [
            SizedBox(
              height: 70,
            ),
            Center(
              child: Icon(
                Icons.account_circle_rounded,
                color: Colors.white,
                size: 100,
              ),
            ),
            appDisabledInputField("Phone", "Phone Number", phoneNumberController,
                TextInputType.number),
            const SizedBox(
              height: 20,
            ),
            appInputFieldError("Name", "Full Name *", userNameController,
                TextInputType.name, ""),
            const SizedBox(
              height: 20,
            ),
            appInputFieldMail("Email", "e-Mail ID", emailController,
                TextInputType.emailAddress),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: (() => {
                // ()
              }),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColorPalette.appPrimary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: getAppSemiboldTextColor('Continue',
                      18, AppColorPalette.appBgColor),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
