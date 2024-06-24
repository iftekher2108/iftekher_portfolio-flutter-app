import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // final controller = WebViewController()
  // ..setJavaScriptMode(JavaScriptMode.unrestricted)
  // ..loadRequest(Uri.parse("http://localhost"));
  // This widget is the root of your application.
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
      appBar: AppBar(
        centerTitle: true,
        title:Text(
          widget.title.toUpperCase(),
          style:TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
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
        backgroundColor: Color(0xFF407BE9),
        // backgroundColor: Color.fromRGBO(100, 149, 237, 1),

        // title: Text(widget.title),

      ),

      body:SafeArea(
        child:WebViewWidget(
          controller: webViewController,
          )
      ),
       
      
      // Container(
      //     padding: EdgeInsets.all(10),
      //   child:Column(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: [
            
      //   ],),



      //   ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          webViewController.reload();
        },
        backgroundColor: Color(0xFF407BE9),
        shape: CircleBorder(),
        tooltip: 'Increment',
        child: const Icon(
          Icons.refresh,
        color: Colors.white,

        ),
      ), 


    );
  }
}
