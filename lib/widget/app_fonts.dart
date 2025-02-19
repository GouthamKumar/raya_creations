import 'package:flutter/material.dart';


Widget getAppLocationText(String displayText){
  return displayText.length>14 ?
  Text("${displayText.substring(0,10)} ..",style: const TextStyle(fontFamily:'lato', fontWeight: FontWeight.w400,fontSize: 12,color: Colors.red,overflow: TextOverflow.ellipsis),)
      : Text(displayText,style: const TextStyle(fontFamily:'lato', fontWeight: FontWeight.w400,fontSize: 12,color: Colors.red,overflow: TextOverflow.ellipsis),);
}


Widget getAppLocationThinText(String displayText,double requiredFontSize){

  return displayText.length>14 ?  Text("${displayText.substring(0,12)} ..",style: TextStyle(fontFamily:'lato', fontWeight: FontWeight.w400,fontSize: requiredFontSize,color: Colors.black,  ),)
  :Text("${displayText}",style: TextStyle(fontFamily:'lato', fontWeight: FontWeight.w400,fontSize: requiredFontSize,color: Colors.black,  ),);
}

Widget getAppThinText(String displayText,double requiredFontSize){

  return Text(displayText,style: TextStyle(fontFamily:'lato', fontWeight: FontWeight.w300,fontSize: requiredFontSize,  ),);
}

Widget getAppRegularTextText(String displayText){
  return Text(displayText,style: const TextStyle(fontFamily:'lato', fontWeight: FontWeight.w400 ),);
}

Widget getAppRegularText(String displayText,double requiredFontSize){
  return Text(displayText,style:  TextStyle(fontFamily:'lato', fontWeight: FontWeight.w400,fontSize: requiredFontSize ),);
}

Widget getAppRegularTextHomeTab(String displayText,Color textColor){
  return Text(displayText,style:  TextStyle(color:textColor,fontSize: 12,fontWeight: FontWeight.w700));
}

Widget getAppRegularTextUnderLine(String displayText,double requiredFontSize){
  return Text(displayText,style:  TextStyle(decoration: TextDecoration.underline,fontFamily:'lato', fontWeight: FontWeight.w400,fontSize: requiredFontSize ),);
}

Widget getAppRegularTextColor(String displayText,double requiredFontSize,Color textColor){
  return Text(displayText,style:  TextStyle(color:textColor, fontFamily:'lato', fontWeight: FontWeight.w400,fontSize: requiredFontSize ),);
}

Widget getAppRegularTextCenter(String displayText,double requiredFontSize){
  return Text(overflow: TextOverflow.ellipsis,displayText,textAlign: TextAlign.center,maxLines: 1,style:  TextStyle(fontFamily:'lato', fontWeight: FontWeight.w400,fontSize: requiredFontSize ),);
}

Widget getAppRegularTextCenterColor(String displayText,double requiredFontSize,Color textColor){
  return Text(overflow: TextOverflow.ellipsis,displayText,textAlign: TextAlign.center,maxLines: 1,style:  TextStyle(color:textColor,fontFamily:'lato', fontWeight: FontWeight.w400,fontSize: requiredFontSize ),);
}
Widget getAppSemiboldText(String displayText,double requiredFontSize){
  return Text(displayText,style:  TextStyle(fontFamily:'lato', fontWeight: FontWeight.w600,fontSize: requiredFontSize ),);
}
Widget getAppSemiboldTextColor(String displayText,double requiredFontSize,Color textColor){
  return Text(displayText,style:  TextStyle(color:textColor, fontFamily:'lato', fontWeight: FontWeight.w600,fontSize: requiredFontSize ),);
}

Widget getAppSemiBoldTextCenter(String displayText,double requiredFontSize){
  return Text(overflow: TextOverflow.ellipsis,displayText,textAlign: TextAlign.center,maxLines: 1,style:  TextStyle(fontFamily:'lato', fontWeight: FontWeight.w600,fontSize: requiredFontSize ),);
}

Widget getAppSemiBoldTextCenterLines(String displayText,double requiredFontSize,int lines){
  return Text(overflow: TextOverflow.ellipsis,displayText,textAlign: TextAlign.center,maxLines: lines,style:  TextStyle(fontFamily:'lato', fontWeight: FontWeight.w600,fontSize: requiredFontSize ),);
}

Widget getAppSemiBoldTextCenterLinesColor(String displayText,double requiredFontSize,int lines,Color textColor){
  return Text(overflow: TextOverflow.ellipsis,displayText,textAlign: TextAlign.center,maxLines: lines,style:  TextStyle(color:textColor, fontFamily:'lato', fontWeight: FontWeight.w600,fontSize: requiredFontSize ),);
}

Widget getAppSemiBoldTextLines(String displayText,double requiredFontSize,int lines,Color color){
  return Text(overflow: TextOverflow.ellipsis,displayText,textAlign: TextAlign.start,maxLines: lines,style:  TextStyle(fontFamily:'lato', fontWeight: FontWeight.w600,fontSize: requiredFontSize,color: color ),);
}


Widget getAppBoldText(String displayText){
  return Text(displayText,style:  const TextStyle(fontFamily:'lato', fontWeight: FontWeight.w700,fontSize: 14 ),);
}

Widget getAppBoldTextSize(String displayText,double requiredFontSize){
  return Text(displayText,style:  TextStyle(fontFamily:'lato', fontWeight: FontWeight.w700,fontSize: requiredFontSize ),);
}

Widget getAppBoldTextSizeColor(String displayText,double requiredFontSize,Color rColor){
  return Text(displayText,style:  TextStyle(fontFamily:'lato', fontWeight: FontWeight.w700,fontSize: requiredFontSize,color: rColor),);
}

Widget getAppBoldTextSizeColorCenter(String displayText,double requiredFontSize,Color rColor){
  return Text(displayText,textAlign: TextAlign.center,style:  TextStyle(fontFamily:'lato', fontWeight: FontWeight.w700,fontSize: requiredFontSize,color: rColor),);
}

Widget getAppThinTextSizeSingle(String displayText,double requiredFontSize){
  return Text(displayText,overflow: TextOverflow.ellipsis,maxLines: 1,style:  TextStyle(fontFamily:'lato', fontWeight: FontWeight.w300,fontSize: requiredFontSize ),);
}

Widget getAppBoldTextSizeSingle(String displayText,double requiredFontSize){
  return displayText.length>20 ? Text("${displayText.substring(0,20)} ..",style:  TextStyle(fontFamily:'lato', fontWeight: FontWeight.w700,fontSize: requiredFontSize ),): Text(displayText,overflow: TextOverflow.ellipsis,maxLines: 1,style:  TextStyle(fontFamily:'lato', fontWeight: FontWeight.w700,fontSize: requiredFontSize ),);
}

Widget getAppBoldTextSizeTwo(String displayText,double requiredFontSize){
  return Text(displayText,overflow: TextOverflow.ellipsis,maxLines: 2,style:  TextStyle(fontFamily:'lato', fontWeight: FontWeight.w700,fontSize: requiredFontSize ),);
}

Widget getAppRegularHeaderText(String displayText){
  return Text(displayText,style: const TextStyle(fontFamily:'lato', fontWeight: FontWeight.w800,fontSize: 16 ),);
}

Widget getAppRegularHeaderTextCenter(String displayText){
  return

    Align(
        alignment: Alignment.center,
        child: Text(displayText,style: const TextStyle(fontFamily:'lato', fontWeight: FontWeight.w700,fontSize: 16),textAlign:TextAlign.center)
    );

}

Widget getAppRegularTextCenterAlign(String displayText,double requiredFontSize){
  return

    Align(
        alignment: Alignment.center,
        child: Text(displayText,style: TextStyle(fontFamily:'lato', fontWeight: FontWeight.w400,fontSize: requiredFontSize),textAlign:TextAlign.center)
    );

}

Widget getAppBoldTextCenterAlign(String displayText,double requiredFontSize){
  return

    Align(
        alignment: Alignment.center,
        child: Text(displayText,style: TextStyle(fontFamily:'lato', fontWeight: FontWeight.w700,fontSize: requiredFontSize),textAlign:TextAlign.center)
    );

}

Widget getAppRegularHeaderTextLeft(String displayText){
  return

    Align(
        alignment: Alignment.centerLeft,
        child: Text(displayText,style: const TextStyle(fontFamily:'lato', fontWeight: FontWeight.w700,fontSize: 16),textAlign:TextAlign.center)
    );

}


Widget getAppStrikeOutTextGray(String displayText){
  return Text(displayText,style: const TextStyle(
    color: Color(0xff8b8b8b),
    fontFamily:'lato', fontWeight: FontWeight.w700,fontSize: 9,
    decoration: TextDecoration.lineThrough,
  ));
}

Widget getAppStrikeOutText(String displayText){
  return Text(displayText,style: const TextStyle(
    color: Color(0xff8b8b8b),
    fontFamily:'lato', fontWeight: FontWeight.w700,fontSize: 16,
    decoration: TextDecoration.lineThrough,
  ));
}

Widget getAppStrikeRegularOutText(String displayText){
  return Text(displayText,style: const TextStyle(
    color: Color(0xff8b8b8b),
    fontFamily:'lato',fontSize: 14,
    decoration: TextDecoration.lineThrough,
  ));
}

Widget getAppStrikeRegularOutTextSize(String displayText, double textSize){
  return Text(displayText,style: const TextStyle(
    color: Color(0xff8b8b8b),
    fontFamily:'lato',fontSize: 14,
    decoration: TextDecoration.lineThrough,
  ));
}
Widget getAppStrikeRegularOutTextSizeColor(String displayText, double textSize, Color textColor){
  return Text(displayText,style:  TextStyle(
    color: textColor,
    fontFamily:'lato',fontSize: 14,
    decoration: TextDecoration.lineThrough,
  ));
}
Widget getAppPriceText(String displayText){
  return Text(displayText,style: const TextStyle(
    color:Color(0xff8b8b8b),
    fontFamily:'lato', fontWeight: FontWeight.w700,fontSize: 16,
  ));
}

Widget getAppRegularTextLines(String displayText,double requiredFontSize,int lines){
  return Text(displayText,maxLines: lines, softWrap: false,overflow: TextOverflow.ellipsis, style:  TextStyle(fontFamily:'lato', fontWeight: FontWeight.w400,fontSize: requiredFontSize ),);
}

Widget getAppRegularTextLinesCenter(String displayText,double requiredFontSize,int lines){
  return Text(displayText,textAlign: TextAlign.center, maxLines: lines, softWrap: false,overflow: TextOverflow.ellipsis, style:  TextStyle(fontFamily:'lato', fontWeight: FontWeight.w400,fontSize: requiredFontSize ),);
}

Widget getAppBoldTextLines(String displayText,double requiredFontSize,int lines){
  return Text(displayText,maxLines: lines, softWrap: false,overflow: TextOverflow.ellipsis, style:  TextStyle(fontFamily:'lato', fontWeight: FontWeight.w700,fontSize: requiredFontSize ),);
}

Widget getAppWalletPriceText(String displayText, Color textColor,double displayFontSize){
  return Text(displayText,style:  TextStyle(
    color: textColor,
    fontFamily:'lato', fontWeight: FontWeight.w700,fontSize: displayFontSize,
  ));
}


Widget getAppPriceTextSize(String displayText,double requiredFontSize,Color textColor){
  return Text(displayText,style:  TextStyle(color: textColor, fontFamily:'lato', fontWeight: FontWeight.w700,fontSize: requiredFontSize ),);
}

Widget getAppRegularUnderLineText(String displayText,double requiredFontSize){
  return Text(displayText,style:  TextStyle(decoration: TextDecoration.underline ,fontFamily:'lato', fontWeight: FontWeight.w400,fontSize: requiredFontSize ),);
}