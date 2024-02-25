
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';


Future<void> showWebViewDialog(BuildContext context,String url) async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: _WebViewExample(uri: url,),
        );
      },
    );
  }

class _WebViewExample extends StatefulWidget {
String  uri;
  _WebViewExample({required this.uri});
  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<_WebViewExample> {
  late PlatformWebViewController _controller;

  @override
  void initState() {
    super.initState();
print(widget.uri);
    // Initialize _controller in initState
    _controller = PlatformWebViewController(
      const PlatformWebViewControllerCreationParams(),
    )..loadRequest(
        LoadRequestParams(
          uri: Uri.parse(widget.uri), // Access the uri from widget
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    // Your build method implementation
    return PlatformWebViewWidget(
      PlatformWebViewWidgetCreationParams(controller: _controller),
    ).build(context);
  }
}
