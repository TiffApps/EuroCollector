// import 'dart:io';

// import 'package:archive/archive.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';

// const api = 'https://';

// class AdditionalData extends StatefulWidget {
//   const AdditionalData({Key? key}) : super(key: key);

//   @override
//   _AdditionalDataState createState() => _AdditionalDataState();
// }

// class _AdditionalDataState extends State<AdditionalData> {
//   String? _dir;
//   List<String>? _images;

//   @override
//   void initState() {
//     super.initState();
//     _downloadAssets('countries');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // floatingActionButton: FloatingActionButton(
//       //   child: const Icon(Icons.style),
//       //   onPressed: () async {
//       //     await
//       //   },
//       // ),
//       body: ListView.builder(
//           itemCount: _images!.length,
//           itemBuilder: (BuildContext context, int index) {
//             return _getImage(_images![index], _dir!);
//           }),
//     );
//   }

//   Widget _getImage(String name, String dir) {
//     var file = _getLocalImageFile(name, dir);
//     return Image.file(file);
//   }

//   File _getLocalImageFile(String name, String dir) => File('$dir/$name');

//   Future<void> _downloadAssets(String name) async {
//     _dir ??= (await getApplicationDocumentsDirectory()).path;

//     if (!await _hasToDownloadAssets(name, _dir!)) {
//       return;
//     }
//     var zippedFile = await _downloadFile(
//         '$api/$name.zip?alt=media&token=7442d067-a656-492f-9791-63e8fc082379',
//         '$name.zip',
//         _dir!);

//     var bytes = zippedFile.readAsBytesSync();
//     var archive = ZipDecoder().decodeBytes(bytes);

//     for (var file in archive) {
//       var filename = '$_dir/${file.name}';
//       if (file.isFile) {
//         var outFile = File(filename);
//         outFile = await outFile.create(recursive: true);
//         await outFile.writeAsBytes(file.content);
//       }
//     }
//   }

//   Future<bool> _hasToDownloadAssets(String name, String dir) async {
//     var file = File('$dir/$name.zip');
//     return !(await file.exists());
//   }

//   Future<File> _downloadFile(String url, String filename, String dir) async {
//     var req = await http.Client().get(Uri.parse(url));
//     var file = File('$dir/$filename');
//     return file.writeAsBytes(req.bodyBytes);
//   }
// }
