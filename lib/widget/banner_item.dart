import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';

class BannerItem extends StatefulWidget {
  BannerItem({super.key});

  @override
  State<StatefulWidget> createState() => _BannerItemState();
}

class _BannerItemState extends State<BannerItem> {
  int _current = 0;
  CarouselController _controller = CarouselController(initialItem: 1);
  List<String> appBanners = [
    'https://api.rayacreations.com/api/writable/uploads/images/banner/_5.jpg',
    'https://api.rayacreations.com/api/writable/uploads/images/banner/_6.jpg',
    'https://api.rayacreations.com/api/writable/uploads/images/banner/_7.jpg',
    'https://api.rayacreations.com/api/writable/uploads/images/banner/_8.jpg'
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.all(0),
        child: Column(
          children: [
            CarouselSlider(
              items: appBanners
                  .map((item) => ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: FadeInImage(
                          fadeInDuration: const Duration(milliseconds: 2),
                          fadeOutDuration: const Duration(milliseconds: 2),
                          fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width,
                          placeholder: AssetImage('images/raya_logo.png'),
                          image: NetworkImage(item),
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'images/raya_logo.png',
                              fit: BoxFit.fitWidth,
                              width: MediaQuery.of(context).size.width,
                            );
                          },
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                enlargeCenterPage: true,
                autoPlay: true,
                scrollPhysics: const ScrollPhysics(),
                autoPlayInterval: const Duration(seconds: 5),
                viewportFraction: 1,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: appBanners.map(
                (image) {
                  int index = appBanners.indexOf(image);
                  return Container(
                    width: 6.0,
                    height: 6.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (_current == index)
                            ? const Color(0xffF04D6B)
                            : Colors.black26),
                  );
                },
              ).toList(),
            )
          ],
        ),
      );
}
