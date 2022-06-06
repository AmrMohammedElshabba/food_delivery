import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';

import 'package:food_delivery/utlis/colors.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.headline1!.copyWith(overflow: TextOverflow.ellipsis),maxLines: 1,
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            Wrap(
                children: List.generate(5, (index) {
              return  Icon(
                Icons.star,
                color: KmainColor,
                size: 15.w,
              );
            })),
            SizedBox(
              width: 5.w,
            ),
            Text(
              "4.5",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              "1255",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Text(
              " comments",
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            IconAndTextWidget(
              text: "Normal",
              iconColor: KiconColor1,
              icon: Icons.circle_sharp,
            ),
            IconAndTextWidget(
              text: "1.7km",
              iconColor: KmainColor,
              icon: Icons.location_on,
            ),
            IconAndTextWidget(
              text: "32min",
              iconColor: KiconColor2,
              icon: Icons.access_time,
            ),
          ],
        )
      ],
    );
  }
}
