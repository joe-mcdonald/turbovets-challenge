import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({super.key});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageFinished: (String url) {
                _updateTheme();
              },
            ),
          )
          // Comment out if testing on a physical device:
          ..loadRequest(Uri.parse('http://localhost:4200'));
    // Use this if testing on a physical device. Replace xxx.xxx with your local IP address:
    // ..loadRequest(Uri.parse('http://192.168.xxx.xxx:4200'));
    // Use this if testing on Android:
    // ..loadRequest(Uri.parse('http://10.0.2.2:4200'));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateTheme();
  }

  // Update the theme in the webview
  void _updateTheme() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    _controller.runJavaScript('''
      if (window.updateFlutterTheme) {
        window.updateFlutterTheme($isDark);
      }
    ''');
  }

  // Reload the webview when the theme changes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Internal Dashboard')),
      body: WebViewWidget(controller: _controller),
    );
  }
}
