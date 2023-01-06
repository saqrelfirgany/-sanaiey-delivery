class PaymentModel {
  dynamic id;
  dynamic image;
  dynamic title;
  PaymentModel({this.id, this.image, this.title});
}

List<PaymentModel> paymentList = [
  PaymentModel(
    id: 1,
    image: 'images/credit.png',
    title: 'نقدا',
  ),
  // PaymentModel(
  //   id: 2,
  //   image: 'images/credit.png',
  //   title: 'MyFatorah',
  // )
];
