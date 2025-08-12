import 'package:raya_mobile/app/models/audio_rooms_response.dart';
import 'package:raya_mobile/app/network/api_constants.dart';
import 'package:raya_mobile/app/network/api_repository.dart';
import 'package:raya_mobile/utils/generic/api_result_data.dart';

class AudioRoomsRepo {
  final ApiRepository apiRepository = ApiRepository();

  Future<Result<AudioResponse>> getAudioRooms() async {
    final audioRooms = await apiRepository.performRequest<AudioResponse>(
        requestType: RequestType.getAudios,
        requestMethod: RequestMethod.get);
    return audioRooms.toResult();
  }
}
