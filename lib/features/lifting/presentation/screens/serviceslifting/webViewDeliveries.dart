import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../config/theme/app_theme.dart';
import '../../../../../shared/widgets/AppBar.dart';
import '../../../../../shared/widgets/side_menu.dart';

class webview extends StatefulWidget {
  final String url;
  const webview({super.key, required this.url});

  @override
  State<webview> createState() => _webviewState();
}

class _webviewState extends State<webview> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late final WebViewController controller;

  @override
  void initState() {
    print('${widget.url}');
    controller = WebViewController()
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
      ..loadRequest(Uri.parse(widget.url.contains('https://') ?
      widget.url : 'https://${widget.url}'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.url);
    return Scaffold(
      backgroundColor: AppTheme.whiteMattsaLight,
      appBar: CustomAppBar(title: "Servicios",),
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      body: Stack(
        children: [
          const Center(
            child: CircularProgressIndicator(),
          ),
          PDFView(filePath: widget.url, autoSpacing: false),
          //WebViewWidget(controller: controller),
        ],
      )
    );
  }
}
