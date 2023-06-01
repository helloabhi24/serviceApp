import 'package:flutter/material.dart';

import '../constant/constant.dart';
import '../constant/textstyle.dart';

extension ExtendedString on String {
  static const strFontFamily = "Poppins";

  Text f10w4(
          {Color? textColor = KColors.white,
          TextAlign? textAlign = TextAlign.start,
          int? maxLines,
          FontWeight? fontWeight,
          double? fontSize,
          TextOverflow? overflow}) =>
      Text(this,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          style: KTextStyle.f10w4.copyWith(
              color: textColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontFamily: strFontFamily));
  Text f13w5(
          {Color? textColor = KColors.white,
          TextAlign? textAlign = TextAlign.start,
          int? maxLines,
          FontWeight? fontWeight,
          double? fontSize,
          TextOverflow? overflow}) =>
      Text(this,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          style: KTextStyle.f13w5.copyWith(
              color: textColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontFamily: strFontFamily));
  Text f12w4(
          {Color? textColor = KColors.white,
          TextAlign? textAlign = TextAlign.start,
          int? maxLines,
          FontWeight? fontWeight,
          bool? softWrap,
          double? fontSize,
          TextOverflow? overflow}) =>
      Text(this,
          softWrap: softWrap,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          style: KTextStyle.f12w4.copyWith(
              color: textColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontFamily: strFontFamily));
  Text f14w4(
          {Color? textColor = KColors.white,
          TextAlign? textAlign = TextAlign.start,
          int? maxLines,
          double? height,
          FontWeight? fontWeight,
          double? fontSize,
          TextDecoration? decoration,
          TextOverflow? overflow}) =>
      Text(this,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          style: KTextStyle.f14w4.copyWith(
              color: textColor,
              height: height,
              fontSize: fontSize,
              decoration: decoration,
              fontWeight: fontWeight,
              fontFamily: strFontFamily));
  Text f16w4(
          {Color? textColor = KColors.white,
          TextAlign? textAlign = TextAlign.start,
          int? maxLines,
          double? height,
          FontWeight? fontWeight = FontWeight.w400,
          double? fontSize,
          TextDecoration? decoration,
          TextOverflow? overflow}) =>
      Text(this,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          style: KTextStyle.f16w6.copyWith(
              color: textColor,
              height: height,
              fontSize: fontSize,
              decoration: decoration,
              fontWeight: fontWeight,
              fontFamily: strFontFamily));

  Text f24w7(
          {Color? textColor = KColors.white,
          TextAlign? textAlign = TextAlign.start,
          int? maxLines,
          FontWeight? fontWeight = FontWeight.w700,
          double? fontSize,
          TextDecoration? decoration,
          TextOverflow? overflow}) =>
      Text(this,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          style: KTextStyle.f24w5.copyWith(
              color: textColor,
              fontSize: fontSize,
              decoration: decoration,
              fontWeight: fontWeight,
              fontFamily: strFontFamily));
  Text f16w7(
          {Color? textColor = KColors.white,
          TextAlign? textAlign = TextAlign.start,
          int? maxLines,
          FontWeight? fontWeight = FontWeight.w700,
          double? fontSize,
          TextDecoration? decoration,
          TextOverflow? overflow}) =>
      Text(this,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          style: KTextStyle.f16w5.copyWith(
              color: textColor,
              fontSize: fontSize,
              decoration: decoration,
              fontWeight: fontWeight,
              fontFamily: strFontFamily));

  Text f18w7(
          {Color? textColor = KColors.white,
          TextAlign? textAlign = TextAlign.start,
          int? maxLines,
          FontWeight? fontWeight = FontWeight.w700,
          double? fontSize,
          TextOverflow? overflow}) =>
      Text(this,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          style: KTextStyle.f18w6.copyWith(
              color: textColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontFamily: strFontFamily));
  Text f16w6(
          {Color? textColor = KColors.white,
          TextAlign? textAlign = TextAlign.start,
          int? maxLines,
          FontWeight? fontWeight,
          double? fontSize,
          TextDecoration? decoration,
          TextOverflow? overflow}) =>
      Text(this,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          style: KTextStyle.f16w5.copyWith(
              color: textColor,
              decoration: decoration,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontFamily: strFontFamily));
  Text f18w6(
          {Color? textColor = KColors.white,
          TextAlign? textAlign = TextAlign.start,
          int? maxLines,
          FontWeight? fontWeight,
          double? fontSize,
          TextOverflow? overflow}) =>
      Text(this,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          style: KTextStyle.f18w6.copyWith(
              color: textColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontFamily: strFontFamily));

  Text f20w5(
          {Color? textColor = KColors.white,
          TextAlign? textAlign = TextAlign.start,
          int? maxLines,
          FontWeight? fontWeight,
          double? fontSize,
          TextOverflow? overflow}) =>
      Text(this,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          style: KTextStyle.f24w5.copyWith(
              color: textColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontFamily: strFontFamily));
}
