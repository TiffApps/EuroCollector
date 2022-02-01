import 'package:carousel_slider/carousel_slider.dart';
import 'package:euro_collector/models/country_coin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class FullscreenImageView extends StatefulWidget {
  final List<Coin> listImagesModel;
  final int current;
  const FullscreenImageView(
      {Key? key, required this.listImagesModel, required this.current})
      : super(key: key);
  @override
  _FullscreenImageViewState createState() => _FullscreenImageViewState();
}

class _FullscreenImageViewState extends State<FullscreenImageView> {
  int _current = 0;
  bool _stateChange = false;

  @override
  void initState() {
    super.initState();
  }

  List<T> map<T>(List<Coin> list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i].imageUrl));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    _current = (_stateChange == false) ? widget.current : _current;
    return Container(
        color: Colors.transparent,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CarouselSlider(
                  options: CarouselOptions(
                      autoPlay: false,
                      height: MediaQuery.of(context).size.height / 1.3,
                      viewportFraction: 1.0,
                      onPageChanged: (index, data) {
                        setState(() {
                          _stateChange = true;
                          _current = index;
                        });
                      },
                      initialPage: widget.current),
                  items: map<Widget>(widget.listImagesModel, (index, url) {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(0.0)),
                            child: Image.network(
                              url,
                              fit: BoxFit.fill,
                              height: 400.0,
                            ),
                          )
                        ]);
                  }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: map<Widget>(widget.listImagesModel, (index, url) {
                    return Container(
                      width: 10.0,
                      height: 9.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 5.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (_current == index)
                            ? NeumorphicTheme.accentColor(context)
                            : Colors.grey,
                      ),
                    );
                  }),
                ),
              ],
            )));
  }
}
