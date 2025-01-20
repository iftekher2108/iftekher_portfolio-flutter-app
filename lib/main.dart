import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Iftekher PortFolio',
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Iftekher Portfolio'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
// WebViewController? webViewController;

  final webViewController = WebViewController();

  @override
  void initState() {
    super.initState();
    webViewController
      ..setJavaScriptMode(
        JavaScriptMode.unrestricted,
      )
      ..setNavigationDelegate(
          NavigationDelegate(onNavigationRequest: (NavigationRequest request) {
        // Intercept navigation requests for downloads
        if (request.url.endsWith('.pdf') || request.url.contains('/download')) {
          _handleDownload(request.url);
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      }))
      ..loadRequest(
        Uri.parse("https://iftekher-mahmud.netlify.app"),
      );
  }


  Future<void> _handleDownload(String url) async {
    // Request storage permission
    if (await Permission.storage.request().isGranted) {
      try {
        // Download the file
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          // Get the external storage directory
          final directory = await getExternalStorageDirectory();
          // final directory = Directory('/storage/emulated/0/Android');
          // if (!await directory.exists()) {
          //   await directory.create(recursive: true);
          // }
          final fileName = url.split('/').last;
          final filePath = '${directory?.path}/$fileName';
          final file = File(filePath);

          // Save the file
          await file.writeAsBytes(response.bodyBytes);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('File downloaded to: $filePath')),
          );
        } else {
          throw Exception('Failed to download file');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Download failed: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text('Storage permission denied')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        // centerTitle: true,
        title: Text(
          widget.title.toUpperCase(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            fontFamily: "roboto",
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
        actions: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: IconButton(
                        onPressed: () {
                          webViewController.goBack();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color(0xFF407BE9),
                          size: 20,
                        )),
                  ),
                  Container(
                    height: 45,
                    width: 45,
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: IconButton(
                        onPressed: () {
                          webViewController.reload();
                        },
                        icon: const Icon(
                          Icons.refresh,
                          color: Color(0xFF407BE9),
                          size: 20,
                        )),
                  ),
                  Container(
                    height: 45,
                    width: 45,
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: IconButton(
                        onPressed: () {
                          webViewController.clearCache();
                          webViewController.reload();
                        },
                        icon: const Icon(
                          Icons.monitor_heart,
                          color: Color(0xFF407BE9),
                          size: 20,
                        )),
                  )
                ],
              ))
        ],
        backgroundColor: const Color(0xFF407BE9),
        // backgroundColor: Color.fromRGBO(100, 149, 237, 1),

        // title: Text(widget.title),
      ),
      body: SafeArea(
          child: WebViewWidget(
        controller: webViewController,
      )),

      // Container(
      //     padding: EdgeInsets.all(10),
      //   child:Column(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: [

      //   ],),

      //   ),

      // floatingActionButton: Container(
      //   height: 60,
      //   width: 60,
      //   child: FloatingActionButton(
      //     onPressed: () {
      //       webViewController.reload();
      //     },
      //     backgroundColor: const Color(0xFF407BE9),
      //     shape: const RoundedRectangleBorder(
      //         borderRadius: BorderRadius.all(Radius.circular(10))),
      //     tooltip: 'Reload',
      //     child: const Icon(
      //       Icons.cached,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: BottomAppBar(
      //   height: 60,
      //   notchMargin: 10,
      //   // clipBehavior: Clip.antiAlias,
      //   elevation: 3,
      //   shape: AutomaticNotchedShape(
      //     RoundedRectangleBorder(
      //       side: BorderSide(width: 10.0,color: Colors.white, style: BorderStyle.solid),
      //       borderRadius: BorderRadius.circular(10.0),
      //     ),
      //   ),
      //   color: const Color(0xFF407BE9),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Container(
      //         margin: const EdgeInsets.only(left: 30),
      //         height: 60,
      //         width: 60,
      //         child: FloatingActionButton(
      //           elevation: 3,
      //           onPressed: () {
      //             webViewController.goBack();
      //           },
      //           backgroundColor: Colors.white,
      //           shape: const RoundedRectangleBorder(
      //               borderRadius: BorderRadius.all(Radius.circular(10))),
      //           tooltip: 'Back',
      //           child: const Icon(
      //             Icons.arrow_back,
      //             color: Color(0xFF407BE9),
      //             size: 15,
      //           ),
      //         ),
      //       ),
      //       Container(
      //         margin: const EdgeInsets.only(right: 30),
      //         height: 60,
      //         width: 60,
      //         child: FloatingActionButton(
      //           elevation: 3,
      //           onPressed: () {
      //             webViewController.reload();
      //           },
      //           backgroundColor: Colors.white,
      //           shape: const RoundedRectangleBorder(
      //               borderRadius: BorderRadius.all(Radius.circular(10))),
      //           tooltip: 'Reload',
      //           child: const Icon(
      //             Icons.cached,
      //             color: Color(0xFF407BE9),
      //             size: 15,
      //           ),
      //         ),
      //       ),
      //       Container(
      //         margin: const EdgeInsets.only(right: 30),
      //         height: 60,
      //         width: 60,
      //         child: FloatingActionButton(
      //           elevation: 3,
      //           onPressed: () {
      //             webViewController.clearCache();
      //             webViewController.reload();
      //           },
      //           backgroundColor: Colors.white,
      //           shape: const RoundedRectangleBorder(
      //               borderRadius: BorderRadius.all(Radius.circular(10))),
      //           tooltip: 'Clear Cache',
      //           child: const Icon(
      //             Icons.monitor_heart,
      //             color: Color(0xFF407BE9),
      //             size: 15,
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),

      // Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     FloatingActionButton(
      //       onPressed: () {
      //         webViewController.goBack();
      //       },
      //       backgroundColor: Color(0xFF407BE9),
      //       shape: CircleBorder(),
      //       tooltip: 'Back',
      //       child: const Icon(
      //         Icons.arrow_back,
      //       color: Colors.white,
      //       ),
      //     ),
      //     SizedBox(
      //       height: 10,
      //     ),
      //     FloatingActionButton(
      //       onPressed: () {
      //         webViewController.reload();
      //       },
      //       backgroundColor: Color(0xFF407BE9),
      //       shape: CircleBorder(),
      //       tooltip: 'Reload',
      //       child: const Icon(
      //         Icons.cached,
      //       color: Colors.white,

      //       ),
      //     ),
      //     SizedBox(
      //       height: 10,
      //     ),
      //      FloatingActionButton(
      //       onPressed: () {
      //         webViewController.clearCache();
      //         webViewController.reload();
      //       },
      //       backgroundColor: Color(0xFF407BE9),
      //       shape: CircleBorder(),
      //       tooltip: 'Clear Cache',
      //       child: const Icon(
      //         Icons.monitor_heart,
      //       color: Colors.white,

      //       ),
      //     ),

      //   ],
      // ),
    );
  }
}
