import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';

import 'package:food_delivery/utlis/colors.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;
  double textHeight = 150.h;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf ="";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? Text(
              firstHalf,
              style: Theme.of(context).textTheme.subtitle1,
            )
          : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hiddenText
                  ? Text(
                      firstHalf + "...",
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  : Text(
                      firstHalf + secondHalf,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
              hiddenText
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          hiddenText = !hiddenText;
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            "Show more",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: KmainColor),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: KmainColor,
                          )
                        ],
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        setState(() {
                          hiddenText = !hiddenText;
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            "Show less",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: KmainColor),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_up,
                            color: KmainColor,
                          )
                        ],
                      ),
                    )
            ],
          ),
    );
  }
}
