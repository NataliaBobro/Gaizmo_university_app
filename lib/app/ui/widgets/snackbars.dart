import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

showSuccessSnackBar({String? title}) {
  showSimpleNotification(
    Row(
      children: [
        const Icon(
          Icons.check,
          color: Colors.white,
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Column(
            children: [
              Text(
                title ?? 'Success',
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    background: Colors.green,
  );
}

showErrorSnackBar({String? title}) {
  showSimpleNotification(
    Row(
      children: [
        const Icon(
          Icons.cancel,
          color: Colors.white,
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Column(
            children: [
              Text(
                title ?? 'Error',
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    background: Colors.red,
  );
}
