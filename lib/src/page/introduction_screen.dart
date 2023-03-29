import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:resep_makanan_hipertensi/main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Lottie.asset('assets/lottie/$assetName');
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return ResponsiveSizer(
      builder: (BuildContext, Orientation, ScreenType) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 20.h),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Responsive Sizer Example',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: IntroductionScreen(
              key: introKey,
              globalBackgroundColor: Colors.white,
              allowImplicitScrolling: true,
              autoScrollDuration: 10000000,
              pages: [
                PageViewModel(
                  title: "Dear Mamah,",
                  body:
                      "hipertensi bukanlah penghalang untuk mamah menikmati hidangan enak dan sehat.",
                  image: _buildImage('intro1.json'),
                  decoration: pageDecoration,
                ),
                PageViewModel(
                  title: "",
                  body:
                      "Meskipun ada beberapa makanan yang harus dihindari, tetapi tetap penting untuk memprioritaskan makanan dalam menjaga kesehatan",
                  image: _buildImage('intro2.json'),
                  decoration: pageDecoration,
                ),
                PageViewModel(
                  title: "",
                  body:
                      "Jangan sampai kehilangan nafsu makan karena banyak makanan yang dilarang dan bingung harus makan apa",
                  image: _buildImage('intro4.json'),
                  decoration: pageDecoration,
                ),
                PageViewModel(
                  title: "",
                  bodyWidget: Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Jangan Mie Terus! hehe,   semangat untuk tetap memperhatikan asupan makanan dan menjaga kesehatan mah!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 25.w,
                          height: 10.h,
                          child: _buildImage('made-with-love.json'),
                        ),
                        Text(
                          "Fijey & Pipit",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  decoration: pageDecoration,
                ),
              ],
              onDone: () => _onIntroEnd(context),
              //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
              showSkipButton: false,
              skipOrBackFlex: 0,
              nextFlex: 0,
              showBackButton: true,
              //rtl: true, // Display as right-to-left
              back: const Icon(Icons.arrow_back),
              skip: const Text('Skip',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              next: const Icon(Icons.arrow_forward),
              done: const Text('Done',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              curve: Curves.fastLinearToSlowEaseIn,
              controlsMargin: const EdgeInsets.all(16),
              controlsPadding: kIsWeb
                  ? const EdgeInsets.all(12.0)
                  : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
              dotsDecorator: const DotsDecorator(
                size: Size(10.0, 10.0),
                color: Color(0xFFBDBDBD),
                activeSize: Size(22.0, 10.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
              dotsContainerDecorator: const ShapeDecoration(
                color: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
