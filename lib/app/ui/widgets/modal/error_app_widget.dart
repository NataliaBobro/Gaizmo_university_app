import 'dart:ui';

import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ErrorAppWidget extends StatefulWidget {
  const ErrorAppWidget({super.key});

  @override
  State<ErrorAppWidget> createState() => _ErrorAppWidgetState();
}

class _ErrorAppWidgetState extends State<ErrorAppWidget> {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    return appState.hasErrorBg ?
      Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          left: 0,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Ефект блюру
            child: Container(
              color: Colors.black.withOpacity(0.3),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.wifi_off,
                      color: Colors.white,
                      size: 80,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      getConstant('Bad internet connection'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none
                      ),
                    ),
                    const SizedBox(height: 16),
                    CupertinoButton(
                      minSize: 0.0,
                      padding: const EdgeInsets.only(
                        top: 16,
                        bottom: 200,
                        right: 50,
                        left: 50
                      ),
                      child: const Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 60,
                      ),
                      onPressed: () {
                        appState.fetchConstant();
                      }
                    )
                  ],
                ),
              ),
            ),
          ),
        ) :
      Container();
  }
}
