import 'package:flutter/material.dart';
import 'package:raya_mobile/widget/app_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppBrowserPage extends StatefulWidget {
  final String url;
  final String title;
  const AppBrowserPage({Key? key, required this.url, required this.title})
      : super(key: key);

  @override
  _AppBrowserPageState createState() => _AppBrowserPageState();
}

class _AppBrowserPageState extends State<AppBrowserPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: getAppRegularText(widget.title, 18),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
