import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  final String url;
  const WebviewScreen({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  late final WebViewController webViewController;

  @override
  void initState() {
    super.initState();
    if (Uri.tryParse(widget.url)?.hasAbsolutePath ?? false) {
      webViewController = WebViewController()
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (url) {},
            onPageFinished: (url) {},
            onWebResourceError: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Failed to load page: ${error.description}')),
              );
            },
          ),
        )
        ..loadRequest(Uri.parse(widget.url));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid URL')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ARTICLE",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: webViewController != null
          ? WebViewWidget(controller: webViewController)
          : const Center(child: Text("Invalid URL")),
    );
  }
}
