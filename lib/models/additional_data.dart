import 'dart:io';

//import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DeterminateIndicator extends StatefulWidget {
  const DeterminateIndicator({Key? key}) : super(key: key);

  @override
  _DeterminateIndicatorState createState() => _DeterminateIndicatorState();
}

class _DeterminateIndicatorState extends State<DeterminateIndicator> {
  double downloadProgress = 0;
  String? _dir;

  @override
  initState() {
    downloadImage();
    super.initState();
  }

  Future downloadImage() async {
    // const url =
    //     'https://mega.nz/file/NFw0wKDJ#7yERmCI_ehBduOBLZcw3j6fo8FfjSi2NNhShCnaAVFI';
    const url =
        'https://drive.google.com/file/d/19-h2JPahG7M0O0PnPfHwg5DfDZcSD8n2/view?usp=sharing';

    final request = Request('GET', Uri.parse(url));
    final response = await Client().send(request);
    final contentLength = response.contentLength;
    final zippedFile = await getFile('Countries.zip');
    // final bytes = <int>[];
    // var bytes = zippedFile.readAsBytesSync();
    final bytes = InputFileStream.file(zippedFile);
    var archive = ZipDecoder().decodeBuffer(bytes);

    _dir ??= (await getApplicationDocumentsDirectory()).path;

    for (var file in archive) {
      var filename = '$_dir/${file.name}';
      if (file.isFile) {
        var outFile = File(filename);
        outFile = await outFile.create(recursive: true);
        await outFile.writeAsBytes(file.content);
        print(filename);
      }
    }
  }

  // response.stream.listen(
  //   (streamedBytes) {
  //     bytes.addAll(streamedBytes);

  //     setState(() {
  //       downloadProgress = bytes.length / contentLength!;
  //     });
  //   },
  //   onDone: () async {
  //     setState(() {
  //       downloadProgress = 1;
  //     });
  //     await file.writeAsBytes(bytes);
  //   },
  //   cancelOnError: true,
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          const Positioned.fill(
            child: Image(
              image:
                  AssetImage('assets/image/background/small-leather-cover.png'),
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
                Text(downloadProgress < 1
                    ? "Downloading assets..."
                    : "Completed!"),
                const SizedBox(
                  height: 10,
                ),
                LinearPercentIndicator(
                  animation: true,
                  lineHeight: 25.0,
                  percent: downloadProgress,
                  center:
                      Text('${(downloadProgress * 100).toStringAsFixed(0)}%'),
                  barRadius: const Radius.circular(15),
                  progressColor: Colors.lightGreen,
                ),
                const SizedBox(
                  height: 150,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AdditionalData extends ChangeNotifier {
  double _progress = 0;
  get downloadProgress => _progress;

  void initialise() {
    _progress = 0;
    notifyListeners();
    startDownloading();
  }

  void startDownloading() async {
    notifyListeners();

    const url =
        'https://file-examples.com/wp-content/uploads/2017/11/file_example_MP3_5MG.mp3';
    final request = Request('GET', Uri.parse(url));
    final StreamedResponse response = await Client().send(request);

    final contentLength = response.contentLength;
    // final contentLength = double.parse(response.headers['x-decompressed-content-length']);

    _progress = 0;
    notifyListeners();

    List<int> bytes = [];

    final file = await getFile('song.mp3');
    response.stream.listen(
      (List<int> newBytes) {
        bytes.addAll(newBytes);
        final downloadedLength = bytes.length;
        _progress = downloadedLength / contentLength!;
        notifyListeners();
      },
      onDone: () async {
        print("done!");
        _progress = 1;
        notifyListeners();
        await file.writeAsBytes(bytes);
      },
      onError: (e) {
        print(e);
      },
      cancelOnError: true,
    );
  }
}

Future<File> getFile(String filename) async {
  final dir = await getApplicationDocumentsDirectory();
  // print(dir.path + "/" + filename);
  return File("${dir.path}/$filename");
}
