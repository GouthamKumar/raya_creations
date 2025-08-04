import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:raya_mobile/widget/app_fonts.dart';

class AudioRoomRow extends StatelessWidget {
  const AudioRoomRow({super.key, required this.config});
  final Map<String, dynamic> config;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/audio', arguments: config);
      },
      child: Padding(
        padding: EdgeInsets.all(8),
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
                    return Image.asset(
                      'images/raya_logo.png',
                      fit: BoxFit.fitWidth,
                      width: 100,
                    );
                  },
                ),
              ),
              getAppBoldTextSize(config['secondChannelName'], 16),
            ],
          ),
        ),
      ),
    );
  }
}
