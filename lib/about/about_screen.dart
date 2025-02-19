import 'package:flutter/material.dart';
import 'package:raya_mobile/util/AppColorPalette.dart';
import 'package:raya_mobile/util/app_constanta.dart';
import 'package:raya_mobile/utils/app_browser.dart';
import 'package:raya_mobile/widget/app_divider.dart';
import 'package:raya_mobile/widget/app_fonts.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            getVerticalDivider(70),
            Center(
                child: Image.asset(
              "images/raya_logo.png",
              height: 300,
            )),
            const SizedBox(
              height: 10,
            ),
            getAccountTile("Send mail", "contact@rayacreations.com", "mail",
                "Min. reply time : 2 hrs", Icons.mail),
            const SizedBox(
              height: 10,
            ),
            // getAccountTile("", "Terms & Conditions", "tc",
            //     "Products,Orders,Delivery and Payments", Icons.rule_folder),
            // const SizedBox(
            //   height: 10,
            // ),
            // getAccountTile(
            //     "",
            //     "Privacy Policy",
            //     "pp",
            //     "App data privacy,security and usage",
            //     Icons.privacy_tip_rounded),
            // const SizedBox(
            //   height: 10,
            // ),
            // getAccountTile(
            //     "", "About us", "au", "About Application", Icons.info_outline),
            // const SizedBox(
            //   height: 10,
            // ),
            // getAccountTile("", "Contact us", "wu", "Contact Customer care",
            //     Icons.contact_support),
          ],
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

  void navigateScreen(String option) {
    switch (option) {
      // case "mail":
      //   sendMail();
      //   break;

      case "tc":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AppBrowserPage(
                    url: "https://www.rayacreations.com/terms",
                    title: "Terms & Conditions")));
        break;
      case "pp":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AppBrowserPage(
                    url: "https://www.rayacreations.com/",
                    title: "Privacy Policy")));
        break;
      case "au":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AppBrowserPage(
                    url: "https://rayacreations.com/#aboutUs",
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
