import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:raya_mobile/app/models/aduio_room.dart';
import 'package:raya_mobile/util/AppColorPalette.dart';
import 'package:raya_mobile/util/app_local_data.dart';
import 'package:raya_mobile/util/utils.dart';
import 'package:raya_mobile/widget/app_fonts.dart';
import 'package:raya_mobile/widget/app_snackbar.dart';

class AudioRoomRow extends StatelessWidget {
  const AudioRoomRow({super.key, required this.config});
  final AudioRoom config;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        isUserLoggedIn().then((value) {
          if (value == GlobalValues.GLOBAL_CONST_YES) {
            Navigator.pushNamed(context, '/audio', arguments: config);
          } else {
            // displaySnackBar('Please login join audio room', context);
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text(
                  'Please login',
                  style: TextStyle(fontSize: 18),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => {Navigator.pop(context)},
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: AppColorPalette.appPrimary),
                    ),
                  ),
                  TextButton(
                    onPressed: () => {
                      selectedIndex = 3,
                      Navigator.pop(context),
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(color: AppColorPalette.appPrimary),
                    ),
                  ),
                ],
              ),
            );
          }
        });
      },
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          color: Colors.white70,
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: FadeInImage(
                      fadeInDuration: const Duration(milliseconds: 2),
                      fadeOutDuration: const Duration(milliseconds: 2),
                      fit: BoxFit.fitWidth,
                      width: 100,
                      placeholder: AssetImage('images/raya_logo.png'),
                      image: NetworkImage(''),
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Padding(
                          padding: EdgeInsets.all(4),
                          child: Image.asset(
                            'images/raya_logo.png',
                            fit: BoxFit.fitWidth,
                            width: 80,
                          ),
                        );
                      },
                    ),
                  ),
                  getAppBoldTextLines(config.title, 16, 2),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
