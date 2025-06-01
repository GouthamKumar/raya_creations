class Banner {
  Banner({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.status,
  });

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json['id'],
      name: json['name'],
      imagePath: json['image_path'],
      status: json['status'],
    );
  }

  final String id;
  final String name;
  final String imagePath;
  final String status;

  String toJson() {
    return '{"id": $id, "name": $name, "imagePath": $imagePath, "status": $status}';
  }
}

class BannerList {
  BannerList({
    required this.banners,
  });

  factory BannerList.fromJson(List bannerList) {
    return BannerList(
      banners: bannerList
          .map((i) => Banner.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }

  final List<Banner> banners;
}
