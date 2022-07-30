import 'package:flutter/cupertino.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:sketch/src/app.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

void main() {
  WebView.platform = WebWebViewPlatform();
  // デフォルトで付与されるURLの「#」を取り除く.
  setUrlStrategy(PathUrlStrategy());
  runApp(const MyApp());
}
