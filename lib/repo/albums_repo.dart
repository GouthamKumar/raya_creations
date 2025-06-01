import 'package:raya_mobile/app/models/albums.dart';
import 'package:raya_mobile/app/models/podcasts.dart';
import 'package:raya_mobile/app/network/api_constants.dart';
import 'package:raya_mobile/app/network/api_repository.dart';
import 'package:raya_mobile/utils/generic/api_result_data.dart';

class AlbumsRepo {
  final ApiRepository apiRepository = ApiRepository();

  Future<Result<Albums>> getAlbumList() async {
    final albums = await apiRepository.performRequest<Albums>(
        requestType: RequestType.getPodcastAlbums,
        requestMethod: RequestMethod.get);
    return albums.toResult();
  }

  Future<Result<Podcasts>> getPodCastList(String albumId) async {
    final podcasts = await apiRepository.performRequest<Podcasts>(
        requestType: RequestType.getPodCasts,
        requestMethod: RequestMethod.get,
        data: {'albumId': albumId}
    );
    return podcasts.toResult();
  }
}
