import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const catchUrls = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];

class WebView extends StatefulWidget {
  final String? url;
  final String? statusBarColor;
  final String? title;
  final bool? hideAppBar;
  final bool? backForbid;

  const WebView({
    super.key,
    this.url,
    this.statusBarColor,
    this.title,
    this.hideAppBar,
    this.backForbid = false,
  });

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  // final webViewReference = FlutterWebviewPlugin();
  // late StreamSubscription<String> _onUrlChanged;
  // late StreamSubscription<WebViewStateChanged> _onStateChange;
  // late StreamSubscription<WebViewHttpError> _onHttpError;
  bool exiting = false;

  @override
  void initState() {
    super.initState();
    // webViewReference.close();
    // _onUrlChanged = webViewReference.onUrlChanged.listen((String url) {});
    // _onStateChange =
    //     webViewReference.onStateChanged.listen((WebViewStateChanged state) {
    //   switch (state.type) {
    //     case WebViewState.startLoad:
    //       if (_isToMain(state.url) && !exiting) {
    //         if (widget.backForbid == null) {
    //           webViewReference.launch(widget.url);
    //         } else {
    //           Navigator.pop(context);
    //           exiting = true;
    //         }
    //       }
    //       break;
    //     default:
    //       break;
    //   }
    // });
    // _onHttpError =
    //     webViewReference.onHttpError.listen((WebViewHttpError error) {
    //   print(error);
    // });
  }

  _isToMain(String url) {
    bool contain = false;
    for (final value in catchUrls) {
      if (url.endsWith(value)) {
        contain = true;
        break;
      }
    }
    return contain;
  }

  @override
  void dispose() {
    // _onStateChange.cancel();
    // _onUrlChanged.cancel();
    // _onHttpError.cancel();
    // webViewReference.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    // String statusBarColorStr = widget.statusBarColor;
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }

    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(widget.url!)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url!));
    return Scaffold(
      body: Column(
        children: [
          _appBar(Color(int.parse('0xff$statusBarColorStr')), backButtonColor),
          Expanded(
            child: WebViewWidget(controller: controller),
          ),
        ],
      ),
    );
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: 30,
      );
    }
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  widget.title ?? '',
                  style: TextStyle(color: backButtonColor, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
