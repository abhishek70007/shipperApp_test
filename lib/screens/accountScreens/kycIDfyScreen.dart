import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper_app/Web/screens/home_web.dart';
import '../../constants/spaces.dart';
import '../../controller/navigationIndexController.dart';
import '/functions/kycIdfyApi.dart';
import '/functions/shipperApis/updateShipperApi.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import '/controller/shipperIdController.dart';

class KYCIDfyScreen extends StatefulWidget {
  const KYCIDfyScreen({Key? key}) : super(key: key);

  @override
  State<KYCIDfyScreen> createState() => _KYCIDfyScreenState();
}

class _KYCIDfyScreenState extends State<KYCIDfyScreen> {
  bool isLoaded = false;
  late String url;
  ShipperIdController shipperIdController =
      Get.put(ShipperIdController());
  NavigationIndexController navigationIndexController =
      Get.put(NavigationIndexController());

  apiCalling() async {
    url = await postCallingIdfy();
    print("URL--------------------->$url");
    if (url.isNotEmpty) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    apiCalling();
  }

  @override
  void dispose() {
    super.dispose();
    WebViewController().clearCache();
    WebViewController().clearLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    final PlatformWebViewController _controller = PlatformWebViewController(
      const PlatformWebViewControllerCreationParams(),
    )..loadRequest(LoadRequestParams(uri: isLoaded ? Uri.parse(url) : Uri.parse('https:google.com')));
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(onProgress: (int progress) {
          print("in onProgress------------------------------------->$progress");
        }, onPageStarted: (String url) {
          print("in onPageStarted------------------------------------->$url");
        }, onPageFinished: (String url) async {
          print("in onPageFinished------------------------------------->$url");
          if (url.contains(
              "https://capture.kyc.idfy.com/document-fetcher/digilocker/callback/?code=")) {
            String status = await updateShipperApi(
                comapnyStatus: "verified",
                transporterId: shipperIdController.shipperId.value);
            if (status == "Success") {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeScreenWeb()));
            }
          }
          // This is used to redirect the page after successful completion of kyc and also here we are updating the transporter status
        }, onWebResourceError: (WebResourceError error) {
          print("in onError------------------------------------->$error");
        }, onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        }),
      )
      ..loadRequest(isLoaded ? Uri.parse(url) : Uri.parse('https:google.com'));
    //this is checking whether the redirect url is ready or not, if yes that will displayed else circular progress bar will be displayed.
    return Scaffold(
        body: Container(
      padding: EdgeInsets.fromLTRB(space_4, space_4, space_4, 0),
      child: isLoaded
          ? (!kIsWeb
              ? WebViewWidget(controller: controller)
              : PlatformWebViewWidget(
                  PlatformWebViewWidgetCreationParams(controller: _controller),
                ).build(context))
          : Center(child: CircularProgressIndicator()),
    ));
  }
}
