import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MainBehavior {
  late Stack stack;

  //Banner add
  late BannerAdListener listener;
  late BannerAd myBanner;
  late AdWidget adWidget;
  late Container adContainer;

  //InterstitialAd
  late InterstitialAd mInterstitialAd;


  //BannerAd methods
  void beforeAdContainer() {
    adContainer = Container(
      height: 200,
      color: Colors.white,
      child: const Center(
        child: Text('Here Will show my ad'),
      ),
    );
    stack = Stack(
      children: [
        Center(
          child: adContainer,
        )
      ],
    );
  }

  void initBannerAd() {
    myBanner = BannerAd(
      adUnitId: 'provides account ids',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: listener,);
  }

  void bannerAdListener() {
    listener = BannerAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) => print('BannerAd loaded successfully received.'),
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        // Dispose the ad here to free resources.
        ad.dispose();
        print('BannerAd failed to load: $error');
      },
      // Called when an ad opens an overlay that covers the screen.
      onAdOpened: (Ad ad) => print('BannerAd opened.'),
      // Called when an ad removes an overlay that covers the screen.
      onAdClosed: (Ad ad) => print('BannerAd closed.'),
      // Called when an impression occurs on the ad.
      onAdImpression: (Ad ad) => print('BannerAd impression.'),
    );
  }

  void adBannerWidget() {
    adWidget = AdWidget(ad: myBanner);
  }

  void adBannerContainer() {
    adContainer = Container(
      alignment: Alignment.center,
      child: adWidget,
      width: myBanner.size.width.toDouble(),
      height: myBanner.size.height.toDouble(),
    );
    stack = Stack(
      children: [
        Center(
          child: adContainer,
        )
      ],
    );
  }
  
  
  //InterstitialAd methods

  Future<void> initInterstitialAd() async {
    await InterstitialAd.load(
        adUnitId: 'give here test ids',
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            mInterstitialAd = ad;
            print('..........load succesfully');
            //full screenAd
            mInterstitialAd.fullScreenContentCallback = FullScreenContentCallback(
              onAdShowedFullScreenContent: (InterstitialAd ad) =>
                  print('%ad onAdShowedFullScreenContent.'),
              onAdDismissedFullScreenContent: (InterstitialAd ad) {
                beforeAdContainer();
                print('$ad onAdDismissedFullScreenContent.');
                ad.dispose();
              },
              onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
                print('$ad onAdFailedToShowFullScreenContent: $error');
                ad.dispose();
              },
              onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
            );
            print('..........load succesfully afterrrrrr');
            mInterstitialAd.show();
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ),
    );
  }
}
