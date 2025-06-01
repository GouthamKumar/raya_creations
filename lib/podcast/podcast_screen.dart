import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raya_mobile/app/models/album.dart';
import 'package:raya_mobile/repo/albums_repo.dart';
import 'package:raya_mobile/util/AppColorPalette.dart';
import 'package:raya_mobile/widget/album_card.dart';
import 'package:raya_mobile/widget/app_divider.dart';
import 'package:raya_mobile/widget/app_fonts.dart';
import 'package:raya_mobile/widget/banner_item.dart';

class PodcastScreen extends StatefulWidget {
  const PodcastScreen({super.key});

  @override
  State<PodcastScreen> createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen> {
  List<Album> albums = [];
  final AlbumsRepo albumsRepo = AlbumsRepo();
  var isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAlbums();
  }

  void getAlbums() async {
    final result = await albumsRepo.getAlbumList();
    if (result.data?.arrAlbum.isNotEmpty ?? false) {
      setState(() {
        isLoading = false;
        albums.addAll(result.data?.arrAlbum ?? []);
      });
    } else {
      setState(() {
        isLoading = false;
        albums = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorPalette.appColorWhite,
      appBar: AppBar(
        title: getAppBoldTextSize('Raya Creations', 22),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: ListView(
          children: [
            getVerticalDivider(10),
            BannerItem(),
            if (albums.isNotEmpty) ...[
              for (final album in albums) ...[AlbumRow(album: album)]
            ],
            if (albums.isEmpty) ...[
              isLoading
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Center(
                      child: getAppSemiboldText('No Albums Found', 16),
                    ),
            ],
          ],
        ),
      ),
    );
  }
}
