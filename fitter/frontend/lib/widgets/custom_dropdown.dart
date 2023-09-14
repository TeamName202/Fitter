import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

CustomDropdown customDropdown = CustomDropdown();

class CustomDropdown {
  OverlayEntry recommendation({
    required double width,
    required EdgeInsets margin,
    required LayerLink layerLink,
    required TextEditingController controller,
    required Function onPressed,
  }) {
    const List<String> boxList = ["임시 체육관명 1", "임시 체육관명 2"];

    final boxListLength = boxList.length;

    return OverlayEntry(
        maintainState: true,
        builder: (context) => Positioned(
              width: width,
              child: CompositedTransformFollower(
                link: layerLink,
                showWhenUnlinked: false,
                offset: const Offset(0, 48),
                child: Material(
                  color: Colors.white,
                  child: Container(
                    height:
                        (22 * boxListLength) + (21 * (boxListLength - 1)) + 20,
                    margin: margin,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListView.separated(
                        physics: const ClampingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        itemBuilder: (context, index) {
                          return CupertinoButton(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            pressedOpacity: 1,
                            minSize: 0,
                            onPressed: () {
                              controller.text = boxList.elementAt(index);

                              onPressed();
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                controller.text,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          );
                        },
                        itemCount: boxListLength),
                  ),
                ),
              ),
            ));
  }
}
