import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_test_ads/main_behavior.dart';

void main() {
  initApp();
}

void initApp() async{
  WidgetsFlutterBinding.ensureInitialized();
  print('initApp');
  await MobileAds.instance.initialize();
  print('initApp completed..');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with MainBehavior {

  @override
  void initState() {

    beforeAdContainer();

    bannerAdListener();
    initBannerAd();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('...............build');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: stack,

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () async {
              await myBanner.load();
              adBannerWidget();
              adBannerContainer();
              setState(() {});
            },
            child: const Text('load banner Ad'),
          ),
          TextButton(
            onPressed: () async {
              setState(() {
                stack = Stack(
                  children: const [Center(
                    child: CircularProgressIndicator(),
                  )],
                );
              });
              initInterstitialAd();
            },
            child: const Text('load Interstitial ad'),
          ),
          TextButton(
            onPressed: () {
              beforeAdContainer();
              setState(() {
              });
            },
            child: const Text('clear'),
          ),
        ],
      ),
    );
  }
}
