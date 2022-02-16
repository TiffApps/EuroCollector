import 'package:cached_network_image/cached_network_image.dart';
import 'package:euro_collector/models/country_coin.dart';
import 'package:euro_collector/pages/country_info.dart';
import 'package:euro_collector/utils/bounce_widget.dart';
import 'package:euro_collector/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CountryLine extends StatelessWidget {
  final CountryCoin country;
  const CountryLine({Key? key, required this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
      child: Row(
        children: [
          // FLAG + COUNTRY NAME ?
          Column(
            children: [
              const SizedBox(height: 20),
              BounceWidget(
                callback: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CountryInfo(data: country)),
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: SizedBox(
                      height: 50,
                      width: 75,
                      child: Image.asset(
                        country.flag,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(country.name),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          // SIDE SCROLL COINS
          Expanded(
            child: SizedBox(
              height: 150,
              child: ShaderMask(
                shaderCallback: (Rect rect) {
                  return const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.purple,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.purple
                    ],
                    stops: [
                      0.0,
                      0.05,
                      0.9,
                      1.0
                    ], // 10% purple, 80% transparent, 10% purple
                  ).createShader(rect);
                },
                blendMode: BlendMode.dstOut,
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: country.coins.length,
                  itemBuilder: (BuildContext context, int index) => SizedBox(
                    // width: 120,
                    // height: 100,
                    child: NeumorphicButton(
                      margin: const EdgeInsets.all(5),
                      onPressed: () {},
                      style: const NeumorphicStyle(
                        shape: NeumorphicShape.convex,
                        depth: -2,
                        boxShape: NeumorphicBoxShape.circle(),
                      ),
                      // padding: const EdgeInsets.all(12.0),
                      // child: CachedNetworkImage(
                      //   imageUrl: country.coins[index].imageUrl,
                      //   progressIndicatorBuilder:
                      //       (context, url, downloadProgress) =>
                      //           CircularProgressIndicator(
                      //               value: downloadProgress.progress),
                      //   errorWidget: (context, url, error) =>
                      //       const Icon(Icons.error),
                      // ),
                      // child: Image.network(
                      //   country.coins[index].imageUrl,
                      //   fit: BoxFit.contain,
                      // ),
                      child: Icon(
                        Icons.favorite_border,
                        color: NeumorphicTheme.of(context)!.current!.baseColor,
                        size: coinSizes[index] * 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LineSlots extends StatelessWidget {
  final List<CountryCoin> data;
  const LineSlots({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) =>
              CountryLine(country: data[index]),
        ),
      ],
    );
  }
}
