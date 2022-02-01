// import 'dart:io';
// import 'dart:typed_data';
// import 'package:image/image.dart' as img;
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';

// Uint8List downloadImage(String url) {
//   getApplicationDocumentsDirectory().then((value) {
//     var dir = value.path;
//     File file = File('$dir/test.png');

//     if (file.existsSync()) {
//       file.readAsBytes().then((value) => value);
//     } else {
//       http.get(Uri.parse(url)).then((value) {
//         var bytes = value.bodyBytes;
//         removeWhiteBackground(bytes).then((value) {
//           file.writeAsBytes(value);
//           return value;
//         });
//       });
//     }
//   });
//   return Uint8List.fromList([]);
// }

// Future<Uint8List> removeWhiteBackground(Uint8List bytes) async {
//   img.Image? image = img.decodeImage(bytes);
//   img.Image transparentImage = await colorTransparent(image!, 255, 255, 255);
//   var newPng = img.encodePng(transparentImage);
//   return Uint8List.fromList(newPng);
// }

// Future<img.Image> colorTransparent(
//     img.Image src, int red, int green, int blue) async {
//   var pixels = src.getBytes();
//   for (int i = 0, len = pixels.length; i < len; i += 4) {
//     if (pixels[i] == red && pixels[i + 1] == green && pixels[i + 2] == blue) {
//       pixels[i + 3] = 0;
//     }
//   }

//   return src;
// }

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart';

class _Key {
  final Object providerCacheKey;

  const _Key(this.providerCacheKey);

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is _Key && other.providerCacheKey == providerCacheKey;
  }

  @override
  int get hashCode => providerCacheKey.hashCode;
}

class BackgroundScraper extends ImageProvider<_Key> {
  final ImageProvider imageProvider;

  const BackgroundScraper(this.imageProvider);

  Uint8List whiteToAlpha(Uint8List bytes) {
    final image = decodeImage(bytes);
    final pixels = image!.getBytes(format: Format.rgba);
    final length = pixels.lengthInBytes;
    for (int i = 0; i < length; i += 4) {
      if (pixels[i] == 255 && pixels[i + 1] == 255 && pixels[i + 2] == 255) {
        pixels[i + 3] = 0;
      }
    }
    return Uint8List.fromList(encodePng(image));
  }

  @override
  ImageStreamCompleter load(_Key key, decode) {
    decoder(
      Uint8List bytes, {
      bool? allowUpscaling,
      int? cacheWidth,
      int? cacheHeight,
    }) async {
      return decode(
        whiteToAlpha(bytes),
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
      );
    }

    return imageProvider.load(key.providerCacheKey, decoder);
  }

  @override
  Future<_Key> obtainKey(ImageConfiguration configuration) {
    Completer<_Key>? completer;
    SynchronousFuture<_Key>? result;
    imageProvider.obtainKey(configuration).then((Object key) {
      if (completer == null) {
        result = SynchronousFuture<_Key>(_Key(key));
      } else {
        completer.complete(_Key(key));
      }
    });
    if (result != null) {
      return result!;
    }
    completer = Completer<_Key>();
    return completer.future;
  }
}
