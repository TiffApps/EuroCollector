import 'package:euro_collector/models/country_coin.dart';
import 'package:euro_collector/utils/fullscreen_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CountryInfo extends StatelessWidget {
  final CountryCoin data;

  const CountryInfo({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: const BorderRadius.all(Radius.circular(100)),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Stack(alignment: Alignment.bottomLeft, children: [
                  SizedBox(
                    height: 300,
                    width: screenWidth,
                    child: Image.asset(data.flag, fit: BoxFit.fill),
                  ),
                  Container(
                    height: 100,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          NeumorphicTheme.baseColor(context),
                          Colors.transparent
                        ],
                        stops: const [0.0, 1.0],
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, bottom: 10),
                        child: Text(
                          data.name,
                          style: const TextStyle(fontSize: 40),
                        ),
                      ),
                    ),
                  ),
                ]),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            if (data.description != "")
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(15),
                child: Text(data.description),
              ),
            if (data.coins.isNotEmpty)
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(15),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.coins.length,
                  itemBuilder: (BuildContext context, int index) => Column(
                    children: [
                      Center(
                        child: Text(
                          data.coins[index].value,
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTapDown: (details) {},
                            onTapUp: (details) => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => FullscreenImageView(
                                        listImagesModel: data.coins,
                                        current: index))),
                            child: SizedBox(
                              width: 150,
                              child: Image.network(data.coins[index].imageUrl,
                                  fit: BoxFit.contain),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Flexible(
                            child: Text(
                              data.coins[index].description,
                              maxLines: 10,
                            ),
                          ),
                        ],
                      ),
                      if (index < data.coins.length - 1)
                        const SizedBox(
                          height: 70,
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
