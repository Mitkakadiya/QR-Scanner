
import 'package:flutter/cupertino.dart';
import 'colors.dart';

// const double bodyPadding = 15.0;
const double radius10 = 10.0;
const double radius30 = 30.0;
const double radius13 = 13.0;
const double scale4 = 4.0;
const double scale3 = 3.0;

EdgeInsetsGeometry bodyPadding = const EdgeInsets.all(15);
EdgeInsetsGeometry cardPadding = const EdgeInsets.all(15);
EdgeInsetsGeometry chipPadding = const EdgeInsets.symmetric(vertical: 10,horizontal: 13);

BorderRadiusGeometry borderRadius10 = BorderRadius.circular(10);
BorderRadiusGeometry borderRadius13 = BorderRadius.circular(13);
BorderRadiusGeometry borderRadius15 = BorderRadius.circular(15);

BoxDecoration cardDecoration({BorderRadiusGeometry? radius}) {
  return BoxDecoration(color: colorFFFFFF, borderRadius: radius ?? borderRadius15);
}
