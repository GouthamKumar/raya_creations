import 'package:flutter/material.dart';
import 'package:raya_mobile/util/AppColorPalette.dart';
import 'package:raya_mobile/util/app_constanta.dart';
import 'package:raya_mobile/util/app_local_data.dart';
import 'package:raya_mobile/utils/app_browser.dart';
import 'package:raya_mobile/widget/app_divider.dart';
import 'package:raya_mobile/widget/app_fonts.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  bool isLoggedin = false;
  String userName = '';
  String mobile = '';

  @override
  void initState() {
    super.initState();
    validateUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  validateUser() async {
    userName = await savedUserName() ?? '';
    mobile = await savedUserPhone() ?? '';
    isUserLoggedIn().then((value) {
      if (value == GlobalValues.GLOBAL_CONST_YES) {
        setState(() {
          isLoggedin = true;
        });
      }
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
          
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            getVerticalDivider(70),
            Center(
              child: Icon(
                Icons.account_circle_rounded,
                color: Colors.white,
                size: 100,
              ),
            ),
            if (isLoggedin) ...[
              const SizedBox(
                height: 10,
              ),
              getAppRegularTextColor(userName, 16, AppColorPalette.appBgColor),
              getAppRegularTextColor(mobile, 16, AppColorPalette.appBgColor),
            ],
            const SizedBox(
              height: 10,
            ),
            if (isLoggedin) ...[
              getAccountRow(
                  'Edit Profile', 'update', Icons.account_circle_rounded),
            ],
            getAccountRow('About Us', 'au', Icons.newspaper),
            getAccountRow('Terms & Conditions', 'tc', Icons.policy),
            getAccountRow('Privacy Policy', 'pp', Icons.privacy_tip),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: InkWell(
          onTap: (() => {
                if (isLoggedin)
                  {
                    clearPref().then((value) => {
                          setState(() {
                            isLoggedin = false;
                          })
                        })
                  }
                else
                  {Navigator.pushNamed(context, '/signin')}
              }),
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: AppColorPalette.appPrimary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: getAppSemiboldTextColor(isLoggedin ? 'Logout' : 'Login',
                  18, AppColorPalette.appBgColor),
            ),
          ),
        ),
      ),
    );
  }

  getAccountTile(String tile, String subTitle, String option, String subText,
      IconData icon) {
    return Material(
      color: Colors.white,
      child: InkWell(
        focusColor: Colors.white,
        onTap: () {
          navigateScreen(option);
        },
        child: ListTile(
          title: getAppRegularText(subTitle, 16),
          leading: SizedBox(
            height: double.infinity,
            child: Icon(icon, color: AppColorPalette.appSecondaryColor),
          ),
          subtitle: getAppRegularText(subText, 14),
        ),
      ),
    );
  }

  getAccountRow(String tittle, String option, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(left: 8),
      child: Material(
        color: AppColorPalette.appSecondaryColor,
        child: InkWell(
          onTap: () {
            navigateScreen(option);
          },
          child: ListTile(
            title:
                getAppRegularTextColor(tittle, 16, AppColorPalette.appBgColor),
            leading: SizedBox(
              height: double.infinity,
              child: Icon(icon, color: AppColorPalette.appBgColor),
            ),
            trailing:
                Icon(Icons.chevron_right, color: AppColorPalette.appBgColor),
          ),
        ),
      ),
    );
  }

  void navigateScreen(String option) {
    switch (option) {
      // case "mail":
      //   sendMail();
      //   break;
      case "update":
        Navigator.pushNamed(context, '/userDetails');
        break;

      case "tc":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AppBrowserPage(
                    url: "https://the-swaram.com/#terms",
                    title: "Terms & Conditions")));
        break;
      case "pp":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AppBrowserPage(
                    url: "https://the-swaram.com/#privacy",
                    title: "Privacy Policy")));
        break;
      case "au":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AppBrowserPage(
                    url: "https://the-swaram.com/#home",
                    title: "About Us")));
        break;
      case "wu":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AppBrowserPage(
                    url: "https://rayacreations.com/#footer",
                    title: "Contact Us")));
        break;
    }
  }

  void sendMail() async {
    // final Uri params = Uri(
    //   scheme: 'mailto',
    //   path: AppConstantsUtil.CONTACT_MAIL,
    //   query: 'subject=App Support', //add subject and body here
    // );

    // var url = params.toString();
    // if (await canLaunchUrl(params)) {
    //   await launchUrl(params);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
}
