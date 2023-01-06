import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Models/MianModels/payment.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/utils/responsive.dart';

class PaymentItem extends StatefulWidget {
  const PaymentItem({
    Key? key,
  }) : super(key: key);

  @override
  State<PaymentItem> createState() => _PaymentItemState();
}

class _PaymentItemState extends State<PaymentItem> {
  int selectedPayment = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        paymentList.length,
        (index) {
          return InkWell(
            onTap: () {
              setState(() {
                selectedPayment = index;
              });
            },
            child: Container(
              height: 50.h,
              decoration: decorationRadiusBorder(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    SizedBox(width: 4.w),
                    Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade500),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 10.w,
                          height: 10.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selectedPayment == index ? mainColor : Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Image.asset('assets/icons/cash_payment.png'),
                    ),
                    SizedBox(width: 8.w),
                    FittedBox(
                      child: Text(
                        '${paymentList[index].title}',
                        style: titleNormal(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
