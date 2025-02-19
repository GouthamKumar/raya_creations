
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget basicShimmerEffect(BuildContext context) {
  return getEffect(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 170,
        decoration: const BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
  );
}


Widget getEffect({required Widget child}){
  return Shimmer.fromColors(
      enabled: true,
      baseColor: Colors.blue,
      highlightColor: Colors.white54,
      direction: ShimmerDirection.ltr,
      period: const Duration(seconds: 1),
      child: child
  );
}