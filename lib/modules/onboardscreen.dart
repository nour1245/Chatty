import 'package:chatty/modules/loginscreen.dart';
import 'package:chatty/shared/components/components.dart';
import 'package:chatty/shared/network/local/cash_helper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnboardScreen extends StatefulWidget {
  OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  var pageViewController = PageController();

  List<BoardingModel> board = [
    BoardingModel(
        image: 'assets/images/chatting.png', title: 'Comments', body: ''),
    BoardingModel(
      image: 'assets/images/messaging.png',
      title: 'Chat',
      body: '  ',
    ),
    BoardingModel(
      image: 'assets/images/texting.png',
      title: 'Notfications',
      body: ' ',
    ),
  ];
  var isLast = false;
  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigatAndReplace(
          context,
          LoginScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => submit(),
            child: const Text('SKIP'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) {
                  if (value == board.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: const BouncingScrollPhysics(),
                controller: pageViewController,
                itemBuilder: (context, index) =>
                    buildPageViewItem(board[index]),
                itemCount: board.length,
              ),
            ),
            const SizedBox(
              height: 60.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    effect: CustomizableEffect(
                      activeDotDecoration: DotDecoration(
                        color: Colors.blue,
                        width: 32,
                        height: 12,
                        rotationAngle: 180,
                        verticalOffset: -10,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      dotDecoration: DotDecoration(
                        width: 24,
                        height: 12,
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(16),
                        verticalOffset: 0,
                      ),
                    ),
                    controller: pageViewController,
                    count: board.length),
                const Spacer(),
                FloatingActionButton(
                  child:
                      isLast ? const Text('Login') : const Icon(Icons.forward),
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      pageViewController.nextPage(
                        duration: const Duration(
                          milliseconds: 300,
                        ),
                        curve: Curves.decelerate,
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPageViewItem(BoardingModel model) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image(
                image: AssetImage(model.image),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              model.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              model.body,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      );
}
