import 'package:flutter/material.dart';
import 'package:shop_app/models/onboarding_model/onboardingitem_model.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageViewController = PageController();
  bool isLast = false;
  List<BoardingModel> boardingItems = [
    BoardingModel(
        image: 'assets/images/ahmed_1.jpg',
        title: 'onBoarding_1',
        body: 'Body_1'),
    BoardingModel(
        image: 'assets/images/ahmed_1.jpeg',
        title: 'onBoarding_2',
        body: 'Body_2'),
    BoardingModel(
        image: 'assets/images/ahmed_1.jpg',
        title: 'onBoarding_3',
        body: 'Body_3'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              onPressed: () {
                submit();
              },
              text: 'skip',
              color: Colors.white),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: pageViewController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boardingItems[index]),
                itemCount: boardingItems.length,
                onPageChanged: (int index) {
                  if (index == boardingItems.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  }
                },
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageViewController,
                  count: boardingItems.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.blue,
                    expansionFactor: 4,
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      pageViewController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(image: AssetImage(model.image)),
          ),
          Text(
            model.title,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            model.body,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w200,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
        ],
      );
  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context, const LoginScreen());
      }
    });
  }
}
