import 'dart:typed_data';

import 'document_delivery_stub.dart'
    if (dart.library.io) 'document_delivery_io.dart' as platform;

Future<String> deliverPdf(Uint8List bytes, String filename) {
  return platform.deliverPdf(bytes, filename);
}
