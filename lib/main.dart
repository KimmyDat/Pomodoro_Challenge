import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Color.fromRGBO(230, 77, 61, 1),
        textTheme: TextTheme(
          titleSmall: TextStyle(
              color: Color.fromRGBO(254, 250, 246, 1),
              fontSize: 20,
              fontWeight: FontWeight.w700),
          displayLarge: TextStyle(
            color: Color(0xFF232B55),
          ),
        ),
        cardColor: Color(0xFFF4EDDB),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const fifteenMinutes = 900;
  static const twentyMinutes = 1200;
  static const twentyFiveMinutes = 1500;
  static const thirtyMinutes = 1800;
  static const thirtyFiveMinutes = 2100;
  int breakFiveMinutes = 300;
  int totalSeconds = 0;
  late int selectedTotalSeconds;
  bool isRunning = false;
  bool isSelected15 = false;
  bool isSelected20 = false;
  bool isSelected25 = false;
  bool isSelected30 = false;
  bool isSelected35 = false;
  int totalRound = 0;
  int totalGoal = 0;
  late Timer timer;
  late Timer breakTimer;

  void timeBreak() {
    breakTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (breakFiveMinutes == 0) {
        setState(() {
          totalSeconds = selectedTotalSeconds;
          breakFiveMinutes = 300;
        });
        breakTimer.cancel();
      } else {
        setState(() {
          breakFiveMinutes--;
          totalSeconds--;
        });
      }
    });
  }

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalRound++;
        isRunning = false;
        totalSeconds = breakFiveMinutes;
      });
      timeBreak();
      timer.cancel();
    } else {
      setState(() {
        totalSeconds--;
      });
    }
    if (totalRound == 4) {
      setState(() {
        totalRound = 0;
        totalGoal++;
      });
    }
    if (totalGoal == 12) {
      resetTotal();
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2, 7);
  }

  void resetTimer() {
    setState(() {
      isRunning = false;
      totalSeconds = selectedTotalSeconds;
    });
    timer.cancel();
  }

  void resetTotal() {
    setState(() {
      isRunning = false;
      totalSeconds = 0;
      totalGoal = 0;
      totalRound = 0;
    });
    timer.cancel();
  }

  void checkMinutes() {
    setState(() {
      if (selectedTotalSeconds == 900) {
        isSelected15 = true;
        isSelected20 = false;
        isSelected25 = false;
        isSelected30 = false;
        isSelected35 = false;
      } else if (selectedTotalSeconds == 1200) {
        isSelected15 = false;
        isSelected20 = true;
        isSelected25 = false;
        isSelected30 = false;
        isSelected35 = false;
      } else if (selectedTotalSeconds == 1500) {
        isSelected15 = false;
        isSelected20 = false;
        isSelected25 = true;
        isSelected30 = false;
        isSelected35 = false;
      } else if (selectedTotalSeconds == 1800) {
        isSelected15 = false;
        isSelected20 = false;
        isSelected25 = false;
        isSelected30 = true;
        isSelected35 = false;
      } else if (selectedTotalSeconds == 2100) {
        isSelected15 = false;
        isSelected20 = false;
        isSelected25 = false;
        isSelected30 = false;
        isSelected35 = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(230, 77, 61, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            "POMOTIMER",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ),
      body: Column(
        children: [
          Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.white,
                        width: 150,
                        height: 200,
                        child: Center(
                          child: Text(
                            format(totalSeconds).toString().substring(0, 2),
                            style: TextStyle(
                                color: Theme.of(context).backgroundColor,
                                fontSize: 90,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Container(
                        height: 200,
                        width: 40,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 35,
                            ),
                            Flexible(
                              flex: 1,
                              child: Text(
                                ":",
                                style: TextStyle(
                                    color: Color.fromRGBO(241, 147, 134, 1),
                                    fontSize: 90),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        width: 150,
                        height: 200,
                        child: Center(
                          child: Text(
                            format(totalSeconds).toString().substring(3, 5),
                            style: TextStyle(
                                color: Theme.of(context).backgroundColor,
                                fontSize: 90,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      selectMinutes(
                        context,
                        fifteenMinutes,
                        isSelected15,
                      ),
                      selectMinutes(
                        context,
                        twentyMinutes,
                        isSelected20,
                      ),
                      selectMinutes(
                        context,
                        twentyFiveMinutes,
                        isSelected25,
                      ),
                      selectMinutes(
                        context,
                        thirtyMinutes,
                        isSelected30,
                      ),
                      selectMinutes(
                        context,
                        thirtyFiveMinutes,
                        isSelected35,
                      ),
                    ],
                  ),
                ],
              )),
          Flexible(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: IconButton(
                      iconSize: 120,
                      color: Colors.white,
                      onPressed: isRunning ? onPausePressed : onStartPressed,
                      icon: Icon(isRunning
                          ? Icons.pause_circle_filled_outlined
                          : Icons.play_circle_outlined)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        iconSize: 40,
                        color: Colors.white,
                        onPressed: resetTimer,
                        icon: Icon(Icons.timer_off_outlined)),
                    IconButton(
                        iconSize: 40,
                        color: Colors.white,
                        onPressed: resetTotal,
                        icon: Icon(Icons.settings_backup_restore_rounded)),
                  ],
                )
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$totalRound / 4',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Colors.white.withOpacity(0.5)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'ROUND',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$totalGoal / 12',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Colors.white.withOpacity(0.5)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'GOAL',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Flexible selectMinutes(BuildContext context, int minutes, bool isSelected) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: InkWell(
          onTap: () {
            selectedTotalSeconds = minutes;
            totalSeconds = selectedTotalSeconds;
            checkMinutes();
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border:
                  Border.all(color: Colors.white.withOpacity(0.5), width: 3),
              color:
                  isSelected ? Colors.white : Theme.of(context).backgroundColor,
            ),
            height: 50,
            child: Center(
              child: Text(
                format(minutes).toString().substring(0, 2),
                style: TextStyle(
                    color: isSelected
                        ? Theme.of(context).backgroundColor
                        : Colors.white.withOpacity(0.5),
                    fontSize: 22,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ),
      ),
      flex: 1,
    );
  }
}
