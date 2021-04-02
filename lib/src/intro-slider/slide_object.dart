import 'package:flutter/material.dart';

class Slide {
  // Title widget
  /// If non-null, used instead of [title] and its relevant properties
  Widget? widgetTitle;

  // Title
  String? title;

  int? maxLineTitle;

  TextStyle? styleTitle;

  EdgeInsets? marginTitle;

  // Image
  String? pathImage;

  double? widthImage;

  double? heightImage;

  BoxFit? foregroundImageFit;

  Function? onCenterItemPress;

  // Custom center widget that replaces image
  Widget? centerWidget;

  // Description
  Widget? widgetDescription;

  String? description;

  int? maxLineTextDescription;

  TextStyle? styleDescription;

  EdgeInsets? marginDescription;

  // Individual button actions
  Function? onNextPress;

  Function? onPrevPress;

  // Background color
  Color? backgroundTabColor;

  Color? gradientTabBegin;

  Color? gradientTabEnd;

  AlignmentGeometry? directionColorBegin;

  AlignmentGeometry? directionColorEnd;

  // Background image
  String? backgroundImage;
  BoxFit? backgroundImageFit;
  double? backgroundOpacity;
  Color? backgroundOpacityColor;
  BlendMode? backgroundBlendMode;

  Slide({
    // Title
    this.widgetTitle,
    this.title,
    this.maxLineTitle,
    this.styleTitle,
    this.marginTitle,

    // Image
    this.pathImage,
    this.widthImage,
    this.heightImage,
    this.foregroundImageFit,

    // Center widget
    this.centerWidget,
    this.onCenterItemPress,

    // Description
    this.widgetDescription,
    this.description,
    this.maxLineTextDescription,
    this.styleDescription,
    this.marginDescription,

    // Individual button actions
    this.onNextPress,
    this.onPrevPress,

    // Background color
    this.backgroundTabColor,
    this.gradientTabBegin,
    this.gradientTabEnd,
    this.directionColorBegin,
    this.directionColorEnd,

    // background image
    this.backgroundImage,
    this.backgroundImageFit,
    this.backgroundOpacity,
    this.backgroundOpacityColor,
    this.backgroundBlendMode,
  });
}
