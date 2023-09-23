import 'package:flutter/material.dart';
import 'package:track_me_now/common/widgets/display/backdrop.widget.dart';
import 'package:track_me_now/features/onboarding/widgets/chat-content.widget.dart';
import 'package:track_me_now/features/onboarding/widgets/intro-content.widget.dart';
import 'package:track_me_now/features/onboarding/widgets/device-content.widget.dart';
import 'package:track_me_now/features/onboarding/widgets/map-content.widget.dart';
import 'package:track_me_now/features/onboarding/widgets/profile-content.widget.dart';
import 'package:track_me_now/features/onboarding/widgets/trial-content.widget.dart';

class OnboardingScreen extends StatefulWidget {
  final Function onClose;

  const OnboardingScreen({super.key, required this.onClose});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int page = 1;

  void setPage(int newPage) {
    if (newPage > 0 && newPage < contents.length + 1) {
      setState(() {
        page = newPage;
      });
    }
  }

  final contents = [
    const IntroContent(),
    const DeviceContent(),
    const MapContent(),
    const ChatContent(),
    const ProfileContent(),
    const TrialContent()
  ];

  @override
  Widget build(BuildContext context) {
    return Backdrop(
      color: Colors.blueAccent.withOpacity(.9),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(48),
        child: Card(
          elevation: 4,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: contents[page - 1])),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            contents.length,
                            (index) => Container(
                                  decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                            offset: Offset(0, 1),
                                            blurRadius: 2,
                                            color: Colors.grey)
                                      ],
                                      color: page > index
                                          ? Colors.amber[800]
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  height: 16,
                                  width: 16,
                                )))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (page > 1)
                        ElevatedButton(
                            onPressed: () {
                              setPage(page - 1);
                            },
                            child: const Text('Previous')),
                      ElevatedButton(
                          onPressed: () {
                            if (page < contents.length) {
                              setPage(page + 1);
                            } else {
                              //TODO: Perform API call for start trial
                              widget.onClose();
                            }
                          },
                          child:
                              Text(page == contents.length ? 'Start' : 'Next'))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
