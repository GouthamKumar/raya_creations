import 'package:raya_mobile/app/models/banner.dart';

class Banners {
  Banners({
    required this.status,
    required this.message,
    required this.arrBanners,
  });

  factory Banners.fromJson(Map<String, dynamic> json){
    return Banners(
      status: json['status'],
      message: json['message'],
      arrBanners: BannerList.fromJson((json['result']) as List).banners,
    );
  }

  final bool status;
  final String message;
  final List<Banner> arrBanners;

  String toJson() {
    return '{"Albums:" ${arrBanners.map((banner) => banner.toJson()).toList()} "message": $message }';
  }
}