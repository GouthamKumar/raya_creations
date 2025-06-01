import 'package:raya_mobile/app/models/albums.dart';
import 'package:raya_mobile/app/models/banners.dart';
import 'package:raya_mobile/app/models/podcasts.dart';
import 'package:raya_mobile/app/network/api_constants.dart';
import 'package:raya_mobile/app/network/api_repository.dart';
import 'package:raya_mobile/utils/generic/api_result_data.dart';

class BannersRepo {
  final ApiRepository apiRepository = ApiRepository();

  Future<Result<Banners>> getBanners(String type) async {
    final albums = await apiRepository.performRequest<Banners>(
        requestType: RequestType.getBanners,
        requestMethod: RequestMethod.get,
        data: {'type': type});
    return albums.toResult();
  }
}
