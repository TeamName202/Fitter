import 'package:fitter/models/user_profile.dart';
import 'package:fitter/services/api_service.dart';
import 'package:fitter/widgets/button_mold.dart';
import 'package:fitter/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyPageAlertDialog extends StatelessWidget {
  const MyPageAlertDialog({super.key, required this.userProfile});

  final Future<UserProfile> userProfile;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 340,
        width: 340,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: const Color(0xFF0080FF),
                        width: 5,
                      ),
                    ),
                    child: FutureBuilder(
                      future: userProfile,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: snapshot.data!.image!,
                          );
                        }
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: const Icon(
                            Icons.person,
                            size: 90,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    userProfile.then(
                      (value) => ApiService.deleteProfile(userProfile),
                    );
                  },
                  child: const ButtonMold(
                      btnText: "사 진 삭 제",
                      horizontalLength: 20,
                      verticalLength: 15,
                      buttonColor: false),
                ),
                const ButtonMold(
                    btnText: "사 진 수 정",
                    horizontalLength: 20,
                    verticalLength: 15,
                    buttonColor: true)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Expanded(
              child: InputText(hintText: "이 름"),
            ),
            const Expanded(
              child: InputText(hintText: "박 스"),
            ),
          ],
        ),
      ),
    );
  }
}
