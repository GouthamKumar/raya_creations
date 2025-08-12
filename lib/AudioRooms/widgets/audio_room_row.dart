import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:raya_mobile/app/models/aduio_room.dart';
import 'package:raya_mobile/util/app_local_data.dart';
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
          if(value == GlobalValues.GLOBAL_CONST_YES) {
            Navigator.pushNamed(context, '/audio', arguments: config);
          } else {
            displaySnackBar('Please login join audio room', context);
          }
        });

      },
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Card(
          color: Colors.white70,
          child: Row(
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
                    return Padding(padding: EdgeInsets.all(8), child: Image.asset(
                      'images/raya_logo.png',
                      fit: BoxFit.fitWidth,
                      width: 80,
                    ),);
                  },
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 8), child: getAppBoldTextSize(config.title, 16),),
            ],
          ),
        ),
      ),
    );
  }
}
