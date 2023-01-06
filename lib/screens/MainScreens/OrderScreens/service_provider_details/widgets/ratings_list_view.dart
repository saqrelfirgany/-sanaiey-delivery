import 'package:flutter/material.dart';
import 'package:sanaiey/screens/MainScreens/OrderScreens/service_provider_details/widgets/single_service_provider_rating_card.dart';
import 'package:sanaiey/utils/responsive.dart';

class RatingListView extends StatelessWidget {
  const RatingListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height(context) * .5,
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return SingleServiceProviderRatingCard();
          }),
    );
  }
}
