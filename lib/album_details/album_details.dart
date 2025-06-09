import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:raya_mobile/app/models/album.dart';
import 'package:raya_mobile/app/models/podcast.dart';
import 'package:raya_mobile/bloc/radio/radio_bloc.dart';
import 'package:raya_mobile/bloc/radio/radio_state.dart';
import 'package:raya_mobile/radio/radio_player.dart';
import 'package:raya_mobile/repo/albums_repo.dart';
import 'package:raya_mobile/util/AppColorPalette.dart';
import 'package:raya_mobile/util/radioplayer_bloc_utils.dart';
import 'package:raya_mobile/util/visualizer.dart';
import 'package:raya_mobile/widget/app_fonts.dart';
import 'package:raya_mobile/widget/banner_item.dart';

class AlbumDetailsScreen extends StatefulWidget {
  const AlbumDetailsScreen({super.key});

  @override
  State<AlbumDetailsScreen> createState() => _AlbumDetailsScreenState();
}

class _AlbumDetailsScreenState extends State<AlbumDetailsScreen> {
  List<Podcast> arrPodcasts = [];
  final AlbumsRepo albumsRepo = AlbumsRepo();
  var isLoading = true;
  var isInit = true;
  Album? album;
  final audioSources = <AudioSource>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void getPodcasts() async {
    final result = await albumsRepo.getPodCastList(album?.id ?? '');
    if (result.data?.arrPodcasts.isNotEmpty ?? false) {
      setState(() {
        isLoading = false;
        arrPodcasts.addAll(result.data?.arrPodcasts ?? []);
      });
    } else {
      setState(() {
        isLoading = false;
        arrPodcasts = [];
      });
    }
  }

  void handleMusicPlayer() {
    if(audioSources.isEmpty) {
      for (final podcast in arrPodcasts) {
        audioSources.add(
            AudioSource.uri(Uri.parse(podcast.podcastInfo.podcastUrl ?? '')));
      }

      initAudioPlayer(audioSources);
    }
  }

  void handlePlayButton(RadioPlayerBaseState state) {
    handleMusicPlayer();
    state.isMusicPlaying == true
        ? getAudioHandler().pause()
        : getAudioHandler().play();
    handleMusicPlayAndStop(context, !state.isMusicPlaying, state.selectedSong, album?.name ?? '');
    stopRadioPlayer();
  }

  void handlePreviousButton(RadioPlayerBaseState state) {
    getAudioHandler().seekToPrevious();
    if (state.selectedSong > 0) {
      final selectedIndex = state.isMusicPlaying ? state.selectedSong - 1 : -1;

      handleMusicPlayAndStop(context, state.isMusicPlaying, selectedIndex, album?.name ?? '');
      stopRadioPlayer();
    }
  }

  void handleForwardButton(RadioPlayerBaseState state) {
    getAudioHandler().seekToNext();
    if (state.selectedSong < arrPodcasts.length - 1) {
      final selectedIndex = state.isMusicPlaying ? state.selectedSong + 1 : -1;
      handleMusicPlayAndStop(context, state.isMusicPlaying, selectedIndex, album?.name ?? '');
      stopRadioPlayer();
    }
  }

  void playSelectedAudio(RadioPlayerBaseState state, int selectedRow) async {
    handleMusicPlayer();
    getAudioHandler().play();
    await getAudioHandler().seek(Duration.zero, index: selectedRow);
    handleMusicPlayAndStop(context, true, selectedRow, album?.name ?? '');
    stopRadioPlayer();
  }


  String getBannerImage(RadioPlayerBaseState state) {
    if (state.isMusicPlaying == true) {
      if (state.selectedAlbum == album?.name) {
        return state.selectedSong >= 0 ? arrPodcasts[state.selectedSong].podcastInfo.imagePath ?? '' : album?.imagePath ?? '';
      }
    }
    return album?.imagePath ?? '';
  }

  void stopRadioPlayer () {
    getRadioHandler().stop();
  }

  @override
  Widget build(BuildContext context) {
    album = ModalRoute.of(context)?.settings.arguments as Album?;
    if (arrPodcasts.isEmpty && isInit == true) {
      isInit = false;
      getPodcasts();
    }
    return BlocListener<RadioPlayerBloc, RadioPlayerBaseState>(
        listener: (context, state) {
      if (state is RadioPlayerInitState) {
        // handleMusicPlayer();
      }
      if (state is RadioPlayerState) {
        print("Hello Player");
      }
    }, child: BlocBuilder<RadioPlayerBloc, RadioPlayerBaseState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: getAppRegularHeaderText(album?.name ?? 'Album details'),
            centerTitle: true,
          ),
          body: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: createMusicPlayer(state),
                ),
                // Expanded(child: BannerItem(),),
                Flexible(
                  flex: 2,
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: arrPodcasts.length,
                          itemBuilder: (context, index) {
                            final podcast = arrPodcasts[index];
                            return getRow(podcast, index, state);
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    ));
  }

  Widget getRow(Podcast podcast, int index, RadioPlayerBaseState state) {
    return InkWell(
      onTap: () => {
        // setState(() {
        //   selectedIndex = index;
        // })
        playSelectedAudio(state, index)
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    height: 80,
                    width: 80,
                    child: ClipRRect ( borderRadius: BorderRadius.circular(8.0), child: CachedNetworkImage(
                      imageUrl: podcast.podcastInfo.imagePath ?? '',
                      placeholder: (context, url) => Icon(Icons.filter_drama),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.filter_drama),
                    ),
                  ),),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        podcast.podcastInfo.name,
                        maxLines: 3,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        podcast.podcastInfo.description ?? '',
                        maxLines: 3,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            if (state.isMusicPlaying && state.selectedSong == index && state.selectedAlbum == album?.name) ...[
              Positioned(
                left: 5,
                bottom: 20,
                child: SizedBox(
                  width: 100,
                  child: MiniMusicVisualizer(
                    color: AppColorPalette.appBarColor,
                    width: 2,
                    height: 20,
                    radius: 2,
                    animate: true,
                    barCount: 15,
                    shadows: [
                      BoxShadow(color: AppColorPalette.appBarColor),
                      BoxShadow(color: Colors.black)
                    ],
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget createMusicPlayer(RadioPlayerBaseState state) {
    return Container(
      child: Stack(
        children: [
          Column(children: [
            arrPodcasts.isNotEmpty ? CachedNetworkImage(
              height: 180,
              imageUrl: getBannerImage(state),
              placeholder: (context, url) => Icon(Icons.cloud_off_outlined),
              errorWidget: (context, url, error) =>
                  Icon(Icons.cloud_off_outlined),
            ) : Image.asset("images/raya_logo.png", height: 180,),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Spacer(),
                IconButton.outlined(
                    iconSize: 40,
                    onPressed: () => {handlePreviousButton(state)},
                    icon: Icon(Icons.arrow_left)),
                Spacer(),
                IconButton.outlined(
                    iconSize: 40,
                    onPressed: () => {handlePlayButton(state)},
                    icon: (state.isMusicPlaying && state.selectedAlbum == album?.name)
                        ? Icon(Icons.pause)
                        : Icon(Icons.play_arrow)),
                Spacer(),
                IconButton.outlined(
                    iconSize: 40,
                    onPressed: () => {handleForwardButton(state)},
                    icon: Icon(Icons.arrow_right)),
                Spacer(),
              ],
            )
          ])
        ],
      ),
    );
  }
}
