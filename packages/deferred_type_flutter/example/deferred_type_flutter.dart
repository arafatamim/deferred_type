import 'package:deferred_type_flutter/deferred_type_flutter.dart';
import 'package:flutter/material.dart';

Widget getWidget() {
  return FutureBuilder2<String>(
    future: Future.value("this"),
    builder: (context, state) => state.when(
      success: (result) => Text(result),
      error: (error, stackTrace) => Text(error.toString()),
      inProgress: () => const CircularProgressIndicator(),
      idle: () => const SizedBox.shrink(),
    ),
  );
}
