import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raya_mobile/app/models/album.dart';
import 'package:raya_mobile/util/AppColorPalette.dart';
import 'package:raya_mobile/widget/app_fonts.dart';

class AlbumRow extends StatefulWidget {
  const AlbumRow({super.key, required this.album});

  final Album album;
  @override
  State<AlbumRow> createState() => _AlbumRowState();
}

class _AlbumRowState extends State<AlbumRow> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/albumDetails', arguments: widget.album);
      },
      child: Card(
        color: Colors.white70,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  width: 100,
                  height: 100,
                  imageUrl: widget.album.imagePath,
                  placeholder: (context, url) => Icon(Icons.filter_drama),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.filter_drama),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Center(
                child: getAppBoldText(widget.album.name),
              ),
              Spacer(),
              Icon(Icons.chevron_right),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
