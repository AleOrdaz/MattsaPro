import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../config/theme/app_theme.dart';
import '../../../../../shared/widgets/AppBar.dart';
import '../../../../../shared/widgets/side_menu.dart';

class webViewReport extends StatefulWidget {
  final String id;
  const webViewReport({super.key, required this.id});

  @override
  State<webViewReport> createState() => _webViewReportState();
}

class _webViewReportState extends State<webViewReport> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late final WebViewController controller;

  @override
  void initState() {
    print('https://mattsa.artendigital.mx/lifting/pdf/${widget.id}');
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
      ..loadRequest(Uri.parse('https://mattsa.artendigital.mx/lifting/pdf/${widget.id}'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteMattsaLight,
      appBar: CustomAppBar(title: "Servicios",),
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      body: Stack(
        children: [
          const Center(
            child: CircularProgressIndicator(),
          ),
          WebViewWidget(controller: controller),
        ],
      ),
    );
  }
}
