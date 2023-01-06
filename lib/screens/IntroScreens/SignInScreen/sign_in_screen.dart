// ////
// import 'package:sanaieydeliveryuser/Screens/auth_screens/bloc/login_bloc/login_cubit.dart';
// import 'package:sanaieydeliveryuser/Screens/auth_screens/body/sign_in_background_widget.dart';
// import 'package:sanaieydeliveryuser/utils/files_export.dart';
//
// class SingInScreen extends StatefulWidget {
//   const SingInScreen({Key? key}) : super(key: key);
//
//   @override
//   _SingInScreenState createState() => _SingInScreenState();
// }
//
// class _SingInScreenState extends State<SingInScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   double theHeightOFSizedBoxOverWhiteCard = 0.5;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: mainColor,
//       body: SizedBox(
//         height: height(context),
//         width: width(context),
//         child: Stack(
//           children: [
//             const SignInBackgroundWidget(),
//             SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   const CustomSizedBox(percentageOfHeight: .5),
//                   Center(
//                     child: Neumorphic(
//                       style: NeumorphicStyle(
//                         depth: 5,
//                         lightSource: LightSource.bottom,
//                         boxShape: NeumorphicBoxShape.roundRect(
//                           BorderRadius.circular(30),
//                         ),
//                       ),
//                       child: Container(
//                         child: Form(
//                           key: _formKey,
//                           child: Column(
//                             children: [
//                               const CustomSizedBox(percentageOfHeight: .02),
//                               const CustomText(
//                                   textColor: mainColor,
//                                   text: "Login2",
//                                   percentageOfHeight: .025,
//                                   fontWeight: FontWeight.bold),
//                               const CustomSizedBox(percentageOfHeight: .04),
//                               SizedBox(
//                                 width: width(context) * .8,
//                                 child: const CustomText(
//                                   textColor: mainColor,
//                                   text: "Phone Number",
//                                   percentageOfHeight: .02,
//                                   textAlign: TextAlign.start,
//                                 ),
//                               ),
//                               const CustomSizedBox(percentageOfHeight: .0),
//                               SizedBox(
//                                 width: width(context) * .8,
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     const SizedBox(),
//                                     SizedBox(
//                                       width: width(context) * .5,
//                                       child: TextFormField(
//                                         validator: (v) {
//                                           if (v!.isEmpty) {
//                                             return ("رقم الهاتف مطلوب");
//                                           }
//                                           return null;
//                                         },
//                                         controller: _phoneController,
//                                         keyboardType: TextInputType.number,
//                                       ),
//                                     ),
//                                     Container(
//                                       child: const Center(
//                                         child: CustomText(
//                                           text: "+ 20 ",
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       width: width(context) * .14,
//                                       height: isLandscape(context)
//                                           ? 2 * height(context) * .07
//                                           : height(context) * .07,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         border: Border.all(color: mainColor),
//                                       ),
//                                     ),
//                                     const Icon(
//                                       Icons.check,
//                                       color: mainColor,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const CustomSizedBox(percentageOfHeight: .05),
//                               SizedBox(
//                                 width: width(context) * .8,
//                                 child: const CustomText(
//                                   textColor: mainColor,
//                                   text: "كلمة المرور",
//                                   percentageOfHeight: .02,
//                                   textAlign: TextAlign.start,
//                                 ),
//                               ),
//                               const CustomSizedBox(percentageOfHeight: .0),
//                               SizedBox(
//                                 width: width(context) * .8,
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     const SizedBox(),
//                                     SizedBox(
//                                       width: width(context) * .5,
//                                       child: TextFormField(
//                                         validator: (v) {
//                                           if (v!.isEmpty) {
//                                             return ('كلمة المرور مطلوبة');
//                                           }
//
//                                           return null;
//                                         },
//                                         controller: _passwordController,
//                                       ),
//                                     ),
//                                     Container(
//                                       child: const Center(
//                                         child: Icon(
//                                           Icons.lock_outline,
//                                           color: mainColor,
//                                         ),
//                                       ),
//                                       width: width(context) * .14,
//                                       height: isLandscape(context)
//                                           ? 2 * height(context) * .07
//                                           : height(context) * .07,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         border: Border.all(color: mainColor),
//                                       ),
//                                     ),
//                                     const Icon(
//                                       Icons.check,
//                                       color: mainColor,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const CustomSizedBox(percentageOfHeight: .05),
//                               CustomButton(
//                                 // isLoading: state is LoginLoadingState,
//                                 onTapButton: () {
//                                   if (_formKey.currentState!.validate()) {
//                                     LoginCubit.get(context).getLogin(
//                                       context: context,
//                                       phone: _phoneController.text,
//                                       password: _passwordController.text,
//                                     );
//                                   }
//                                 },
//                                 text: "Login",
//                                 percentageOfHeight: .065,
//                                 percentageOfWidth: .65,
//                               ),
//                               const CustomSizedBox(percentageOfHeight: .04),
//                             ],
//                           ),
//                         ),
//                         width: width(context) * .95,
//                         decoration: BoxDecoration(
//                             color: whiteColor,
//                             borderRadius: BorderRadius.circular(20)),
//                       ),
//                     ),
//                   ),
//                   const CustomSizedBox(percentageOfHeight: .04),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
