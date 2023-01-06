 import 'package:flutter_share/flutter_share.dart';

class CommonFunctions{

   Future<void> share({String title :"" , String text :"" , String linkUrl :"" , String chooserTitle :"chooser title" }) async {
     await FlutterShare.share(
         title: title ,
         text:text ,
         linkUrl: 'https://www.lipsum.com/',
         chooserTitle: chooserTitle);
   }
 }