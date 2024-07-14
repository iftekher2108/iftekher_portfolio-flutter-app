import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

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
      ..loadRequest(
        Uri.parse("https://iftekher2108.github.io/iftekher-portfolio"),
      );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title.toUpperCase(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            fontFamily: "roboto",
            color: Colors.white,
            letterSpacing: 3,
          ),
        ),
        // actions: [
        //   Container(
        //     padding: EdgeInsets.symmetric(horizontal: 30),
        //   child: Row(
        //     children: [
        //       IconButton(
        //         onPressed:(){
        //           print('web back');
        //         },
        //          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30,)
        //       ),
        //       IconButton(
        //         onPressed:(){
        //           print('web refresh');
        //         },
        //          icon: Icon(Icons.refresh, color: Colors.white, size: 30,)
        //       ),
        //       IconButton(
        //         onPressed:(){
        //           print('web forwards history');
        //         },
        //          icon: Icon(Icons.arrow_forward, color: Colors.white, size: 30,)
        //       )

        //     ],
        //   )
        //   )

        // ],
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

      floatingActionButton: SizedBox(
        height: 65,
        width: 65,
        child: FloatingActionButton(
          onPressed: () {
            webViewController.reload();
          },
          backgroundColor: const Color(0xFF407BE9),
          shape: const CircleBorder(),
          tooltip: 'Reload',
          child: const Icon(
            Icons.cached,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: 65,
        notchMargin: 10,
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        shape: const CircularNotchedRectangle(),
        color: const Color(0xFF407BE9),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 30),
                height:45,
                width:45,
                child: FloatingActionButton(
                  elevation: 0,
                  onPressed: () {
                    webViewController.goBack();
                  },
                  backgroundColor: Colors.white,
                  shape: const CircleBorder(),
                  tooltip: 'Back',
                  child: const Icon(
                    Icons.arrow_back,
                    color: Color(0xFF407BE9),
                    size: 15,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 30),
                height:45,
                width:45,
                child: FloatingActionButton(
                  elevation: 0,
                  onPressed: () {
                    webViewController.clearCache();
                    webViewController.reload();
                  },
                  backgroundColor: Colors.white,
                  shape: const CircleBorder(),
                  tooltip: 'Clear Cache',
                  child: const Icon(
                    Icons.monitor_heart,
                    color: Color(0xFF407BE9),
                    size: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

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
