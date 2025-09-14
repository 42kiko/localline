import 'dart:math';

String generateMessageId() {
  final random = Random();
  return DateTime.now().millisecondsSinceEpoch.toString() +
      "_" +
      random.nextInt(100000).toString();
}