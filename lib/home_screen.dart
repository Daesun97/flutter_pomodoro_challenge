import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //라운드와 골 올라가는것 보려주려고 2초로 설정
  static const int twenty = 2;
  static const int twentyFive = 1500;
  static const int thirty = 1800;

  int ts_20 = twenty;
  int ts_25 = twentyFive;
  int ts_30 = thirty;

  int totlaSecond = 1200;
  late int endTotalSecond;
  late Timer timer;
  bool isRunning = false;
  int totalRound = 0;
  int totalGoals = 0;

//타이머가 1초씩 줄어둘다가 0초가되면 ROUND가 1오르고 ROUND도 4가되면 GALS도 1오름
  void onTick(Timer timer) {
    if (totlaSecond == 0) {
      setState(() {
        isRunning = !isRunning;
        totlaSecond = endTotalSecond;
        totalRound += 1;
        if (totalRound == 4) {
          totalGoals += 1;
          totalRound = 0;
        }
      });
      timer.cancel();
    } else {
      setState(() {
        totlaSecond -= 1;
      });
    }
  }

//20분짜리 버튼
  void choice20Minut() {
    timer.cancel();
    endTotalSecond = ts_20;
    setState(() {
      if (isRunning == true) {
        isRunning = false;
      }
      totlaSecond = ts_20;
    });
  }

//25분짜리 버튼
  void choice25Minut() {
    timer.cancel();
    endTotalSecond = ts_25;
    setState(() {
      if (isRunning == true) {
        isRunning = false;
      }
      totlaSecond = ts_25;
    });
  }

//30분짜리 버튼
  void choice30Minut() {
    timer.cancel();
    endTotalSecond = ts_30;
    setState(() {
      if (isRunning == true) {
        isRunning = false;
      }
      totlaSecond = ts_30;
    });
  }

//시작 버튼
  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    setState(() {
      isRunning = !isRunning;
    });
  }

// 일시정지 버튼
  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = !isRunning;
    });
  }

//리셋 버튼
  void onResetPressed() {
    timer.cancel();
    setState(() {
      totlaSecond = endTotalSecond;
      isRunning = !isRunning;
    });
  }

  String format(int second) {
    var duration = Duration(seconds: second);
    return duration.toString().split(".").first.substring(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      //앱 타이틀
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          '공부 시간',
          style: TextStyle(color: Theme.of(context).cardColor),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          //타이머
          Flexible(
            flex: 2,
            child: Text(
              format(totlaSecond),
              style: TextStyle(
                  fontSize: 120,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).cardColor),
            ),
          ),
          //몇분인지 정하는 버튼 옆으로 스크롤 되면 좋음
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: choice20Minut,
                    icon: const Icon(Icons.brightness_4_outlined)),
                const SizedBox(width: 15),
                IconButton(
                    onPressed: choice25Minut,
                    icon: const Icon(Icons.brightness_5_outlined)),
                const SizedBox(width: 15),
                IconButton(
                    onPressed: choice30Minut,
                    icon: const Icon(Icons.brightness_6_outlined)),
              ],
            ),
          ),
          //시작,정지,리셋버튼
          Flexible(
              flex: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: IconButton(
                        color: Theme.of(context).cardColor,
                        iconSize: 100,
                        onPressed: isRunning ? onPausePressed : onStartPressed,
                        icon: Icon(
                          isRunning
                              ? Icons.pause_circle_outline_rounded
                              : Icons.play_circle_outline_outlined,
                        ),
                      ),
                    ),
                    Center(
                      child: IconButton(
                        iconSize: 80,
                        color: Theme.of(context).cardColor,
                        onPressed: onResetPressed,
                        icon: const Icon(Icons.restart_alt_rounded),
                      ),
                    )
                  ],
                ),
              )),
          //라운드, 골
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'ROUND',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Theme.of(context).cardColor),
                      ),
                      Text(
                        "$totalRound/4",
                        style: TextStyle(
                            fontSize: 20, color: Theme.of(context).cardColor),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'GALS',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Theme.of(context).cardColor),
                      ),
                      Text(
                        "$totalGoals/2",
                        style: TextStyle(
                            fontSize: 20, color: Theme.of(context).cardColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
