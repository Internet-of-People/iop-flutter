import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:iop_wallet/src/intro-slider/scrollbar_behavior_enum.dart';
import 'package:iop_wallet/src/theme.dart';

class Slide extends StatelessWidget {
  // Title widget
  /// If non-null, used instead of [title] and its relevant properties
  Widget? widgetTitle;

  // Title
  String? title;

  int? maxLineTitle;

  TextStyle? styleTitle = textTheme.headline1;

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

  TextStyle? styleDescription = textTheme.bodyText1;

  EdgeInsets? marginDescription;

  // Individual button actions
  Function? onNextPress;

  Function? onPrevPress;

  // Background color
  Color? backgroundTabColor = appTheme.backgroundColor;

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

  // Scroll Controller
  ScrollController? scrollController;
  scrollbarBehavior? verticalScrollbarBehavior;

  Slide({
    // Title
    this.widgetTitle,
    this.title,
    this.maxLineTitle,
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
    this.marginDescription,

    // Individual button actions
    this.onNextPress,
    this.onPrevPress,

    // Background color
    this.gradientTabBegin,
    this.gradientTabEnd,
    this.directionColorBegin,
    this.directionColorEnd,

    // Background image
    this.backgroundImage,
    this.backgroundImageFit,
    this.backgroundOpacity,
    this.backgroundOpacityColor,
    this.backgroundBlendMode,

    // Scrollbar Behavior
    this.scrollController,
    this.verticalScrollbarBehavior,
  });

  @override
  Widget build(BuildContext context) {
    final listView = ListView(
      controller: scrollController,
      children: <Widget>[
        Container(
          // Title
          margin: marginTitle ??
              const EdgeInsets.only(
                  top: 70.0, bottom: 50.0, left: 20.0, right: 20.0),
          child: widgetTitle ??
              Text(
                title ?? '',
                style: styleTitle ??
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                maxLines: maxLineTitle ?? 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
        ),

        // Image or Center widget
        GestureDetector(
          onTap: onCenterItemPress as void Function()?,
          child: pathImage != null
              ? Image.asset(
                  pathImage!,
                  width: widthImage ?? 200.0,
                  height: heightImage ?? 200.0,
                  fit: foregroundImageFit ?? BoxFit.contain,
                )
              : Center(child: centerWidget ?? Container()),
        ),

        // Description
        Container(
          margin: marginDescription ??
              const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 50.0),
          child: widgetDescription ??
              Text(
                description ?? '',
                style: styleDescription ??
                    const TextStyle(color: Colors.white, fontSize: 18.0),
                textAlign: TextAlign.center,
                maxLines: maxLineTextDescription ?? 100,
                overflow: TextOverflow.ellipsis,
              ),
        ),
      ],
    );

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: backgroundImage != null
          ? BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImage!),
                fit: backgroundImageFit ?? BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  backgroundOpacityColor != null
                      ? backgroundOpacityColor!
                          .withOpacity(backgroundOpacity ?? 0.5)
                      : Colors.black.withOpacity(backgroundOpacity ?? 0.5),
                  backgroundBlendMode ?? BlendMode.darken,
                ),
              ),
            )
          : BoxDecoration(
              gradient: LinearGradient(
                colors: backgroundTabColor != null
                    ? [backgroundTabColor!, backgroundTabColor!]
                    : [
                        gradientTabBegin ?? Colors.amberAccent,
                        gradientTabEnd ?? Colors.amberAccent
                      ],
                begin: directionColorBegin ?? Alignment.topLeft,
                end: directionColorEnd ?? Alignment.bottomRight,
              ),
            ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 60.0),
        child: verticalScrollbarBehavior != scrollbarBehavior.HIDE
            ? Platform.isIOS
                ? CupertinoScrollbar(
                    controller: scrollController,
                    isAlwaysShown: verticalScrollbarBehavior ==
                        scrollbarBehavior.SHOW_ALWAYS,
                    child: listView,
                  )
                : Scrollbar(
                    controller: scrollController,
                    isAlwaysShown: verticalScrollbarBehavior ==
                        scrollbarBehavior.SHOW_ALWAYS,
                    child: listView,
                  )
            : listView,
      ),
    );
  }
}
