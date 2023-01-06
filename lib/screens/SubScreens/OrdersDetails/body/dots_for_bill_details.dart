
import 'package:flutter/cupertino.dart';
import 'package:sanaiey/screens/SubScreens/OrdersDetails/body/single_dot_for_bill_details.dart';

class DotsForBillDetails extends StatelessWidget {
  const DotsForBillDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * .5,
//            height:isLandscape(context)
//                ? 2*height*.08: height*.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          SingleDotForBillDetails(),
          SingleDotForBillDetails(),
          SingleDotForBillDetails(),
          SingleDotForBillDetails(),
          SingleDotForBillDetails(),
          SingleDotForBillDetails(),
          SingleDotForBillDetails(),
          SingleDotForBillDetails(),
          SingleDotForBillDetails(),
          SingleDotForBillDetails(),
          SingleDotForBillDetails(),
          SingleDotForBillDetails(),
          SingleDotForBillDetails(),
          SingleDotForBillDetails(),
          SingleDotForBillDetails(),
          SingleDotForBillDetails(),
          SingleDotForBillDetails(),
          SingleDotForBillDetails(),
          SingleDotForBillDetails(),
          SingleDotForBillDetails(),
          SingleDotForBillDetails(),
          SingleDotForBillDetails(),
          SingleDotForBillDetails(),
          SingleDotForBillDetails(),
          SingleDotForBillDetails(),
        ],
      ),
    );
  }
}
