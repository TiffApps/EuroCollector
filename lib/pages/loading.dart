import 'package:euro_collector/models/additional_data.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AdditionalData>.nonReactive(
      viewModelBuilder: () => AdditionalData(),
      // disposeViewModel: false,
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
        body: Stack(
          children: <Widget>[
            const Positioned.fill(
              child: Image(
                image: AssetImage(
                    'assets/image/background/small-leather-cover.png'),
                fit: BoxFit.fill,
              ),
            ),
            Center(
              child: SizedBox(
                height: 200,
                child: Image.asset('assets/image/background/stars.png'),
              ),
            ),
            Center(
              child: SizedBox(
                height: 80,
                child: Image.asset('assets/image/background/euro.png'),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(model.downloadProgress < 1
                      ? "Downloading assets..."
                      : "Completed!"),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 300,
                    height: 10,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child:
                        LinearProgressIndicator(value: model.downloadProgress),
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
