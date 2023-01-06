
import 'package:flutter/material.dart';
import 'package:sanaiey/screens/SubScreens/ServiceProviderScreen/body/single_service_provider_card.dart';
import 'package:sanaiey/utils/responsive.dart';

class ServiceProvidersListView extends StatelessWidget {
  const ServiceProvidersListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height(context) * .65,
      child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return const SingleServiceProviderCard();
          }),
    );
  }
}
