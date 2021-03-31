import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iop_wallet/src/theme.dart';

import 'dot_animation_enum.dart';
import 'list_rtl_language.dart';
import 'scrollbar_behavior_enum.dart';
import 'slide_object.dart';

class IntroSlider extends StatefulWidget {
  // ---------- Slides ----------
  /// An array of Slide object
  final List<Slide>? slides;

  /// Background color for all slides
  final Color? backgroundColorAllSlides;

  // ---------- SKIP button ----------
  /// Render your own SKIP button
  final Widget? renderSkipBtn;

  /// Width of view wrapper SKIP button
  final double? widthSkipBtn;

  /// Fire when press SKIP button
  final Function? onSkipPress;

  /// Change SKIP to any text you want
  final String? nameSkipBtn;

  /// Style for text at SKIP button
  final TextStyle? styleNameSkipBtn;

  /// Color for SKIP button
  final Color? colorSkipBtn;

  /// Show or hide SKIP button
  final bool showSkipBtn = false;

  /// Rounded SKIP button
  final double? borderRadiusSkipBtn;

  // ---------- PREV button ----------
  /// Render your own PREV button
  final Widget? renderPrevBtn;

  /// Width of view wrapper PREV button
  final double? widthPrevBtn;

  /// Change PREV to any text you want
  final String? namePrevBtn;

  /// Style for text at PREV button
  final TextStyle? styleNamePrevBtn;

  /// Color for PREV button
  final Color? colorPrevBtn;

  /// Show or hide PREV button (only visible if skip is hidden)
  final bool? showPrevBtn;

  /// Rounded PREV button
  final double? borderRadiusPrevBtn;

  // ---------- NEXT button ----------
  /// Render your own NEXT button
  final Widget? renderNextBtn;

  /// Change NEXT to any text you want
  final String? nameNextBtn;

  /// Show or hide NEXT button
  final bool? showNextBtn;

  // ---------- DONE button ----------
  /// Change DONE to any text you want
  final String? nameDoneBtn;

  /// Render your own DONE button
  final Widget? renderDoneBtn;

  /// Width of view wrapper DONE button
  final double? widthDoneBtn;

  /// Fire when press DONE button
  final Function? onDonePress;

  /// Style for text at DONE button
  final TextStyle? styleDoneBtn = textTheme.bodyText2;

  /// Color for DONE button
  final Color? colorDoneBtn;

  /// Rounded DONE button
  final double? borderRadiusDoneBtn;

  /// Show or hide DONE button
  final bool? showDoneBtn;

  // ---------- Dot indicator ----------
  /// Show or hide dot indicator
  final bool? showDotIndicator;

  /// Color for dot when passive
  final Color colorDot = appTheme.primaryColorLight;

  /// Color for dot when active
  final Color colorActiveDot = appTheme.primaryColorDark;

  /// Size of each dot
  final double? sizeDot;

  /// Type dots animation
  final dotSliderAnimation? typeDotAnimation;

  // ---------- Tabs ----------
  /// Render your own custom tabs
  final List<Widget>? listCustomTabs;

  /// Notify when tab change completed
  final Function? onTabChangeCompleted;

  /// Ref function go to specific tab index
  final Function? refFuncGoToTab;

  // ---------- Behavior ----------
  /// Whether or not the slider is scrollable (or controlled only by buttons)
  final bool? isScrollable;
  final ScrollPhysics? scrollPhysics;

  /// Show or hide status bar
  final bool? hideStatusBar;

  /// The way the vertical scrollbar should behave
  final scrollbarBehavior? verticalScrollbarBehavior;

  // Constructor
  IntroSlider({
    // Slides
    this.slides,
    this.backgroundColorAllSlides,

    // Skip
    this.renderSkipBtn,
    this.widthSkipBtn,
    this.onSkipPress,
    this.nameSkipBtn,
    this.styleNameSkipBtn,
    this.colorSkipBtn,
    this.borderRadiusSkipBtn,

    // Prev
    this.renderPrevBtn,
    this.widthPrevBtn,
    this.namePrevBtn,
    this.showPrevBtn,
    this.styleNamePrevBtn,
    this.colorPrevBtn,
    this.borderRadiusPrevBtn,

    // Done
    this.renderDoneBtn,
    this.widthDoneBtn,
    this.onDonePress,
    this.nameDoneBtn,
    this.colorDoneBtn,
    this.borderRadiusDoneBtn,
    this.showDoneBtn,

    // Next
    this.renderNextBtn,
    this.nameNextBtn,
    this.showNextBtn,

    // Dots
    this.showDotIndicator,
    this.sizeDot,
    this.typeDotAnimation,

    // Tabs
    this.listCustomTabs,
    this.onTabChangeCompleted,
    this.refFuncGoToTab,

    // Behavior
    this.isScrollable,
    this.scrollPhysics,
    this.hideStatusBar,
    this.verticalScrollbarBehavior,
  });

  @override
  IntroSliderState createState() {
    return IntroSliderState(
      // Slides
      slides: slides,
      backgroundColorAllSlides: backgroundColorAllSlides,

      // Skip
      renderSkipBtn: renderSkipBtn,
      widthSkipBtn: widthSkipBtn,
      onSkipPress: onSkipPress,
      nameSkipBtn: nameSkipBtn,
      styleNameSkipBtn: styleNameSkipBtn,
      colorSkipBtn: colorSkipBtn,
      showSkipBtn: showSkipBtn,
      borderRadiusSkipBtn: borderRadiusSkipBtn,

      // Prev
      renderPrevBtn: renderPrevBtn,
      widthPrevBtn: widthPrevBtn,
      namePrevBtn: namePrevBtn,
      showPrevBtn: showPrevBtn,
      styleNamePrevBtn: styleNamePrevBtn,
      colorPrevBtn: colorPrevBtn,
      borderRadiusPrevBtn: borderRadiusPrevBtn,

      // Done
      renderDoneBtn: renderDoneBtn,
      widthDoneBtn: widthDoneBtn,
      onDonePress: onDonePress,
      nameDoneBtn: nameDoneBtn,
      styleNameDoneBtn: styleDoneBtn,
      colorDoneBtn: colorDoneBtn,
      borderRadiusDoneBtn: borderRadiusDoneBtn,
      isShowDoneBtn: showDoneBtn,

      // Next
      renderNextBtn: renderNextBtn,
      nameNextBtn: nameNextBtn,
      showNextBtn: showNextBtn,

      // Dots
      showDotIndicator: showDotIndicator,
      colorDot: colorDot,
      colorActiveDot: colorActiveDot,
      sizeDot: sizeDot,
      typeDotAnimation: typeDotAnimation,

      // Tabs
      listCustomTabs: listCustomTabs,
      onTabChangeCompleted: onTabChangeCompleted,
      refFuncGoToTab: refFuncGoToTab,

      // Behavior
      isScrollable: isScrollable,
      scrollPhysics: scrollPhysics,
      hideStatusBar: hideStatusBar,
      verticalScrollbarBehavior:
          verticalScrollbarBehavior ?? scrollbarBehavior.HIDE,
    );
  }
}

class IntroSliderState extends State<IntroSlider>
    with SingleTickerProviderStateMixin {
  /// Default values
  static TextStyle defaultBtnNameTextStyle = TextStyle(color: Colors.white);

  static double defaultBtnBorderRadius = 30.0;

  static Color defaultBtnColor = Colors.transparent;

  // ---------- Slides ----------
  /// An array of Slide object
  List<Slide>? slides;

  /// Background color for all slides
  Color? backgroundColorAllSlides;

  // ---------- SKIP button ----------
  /// Render your own SKIP button
  Widget? renderSkipBtn;

  /// Width of view wrapper SKIP button
  double? widthSkipBtn;

  /// Fire when press SKIP button
  Function? onSkipPress;

  /// Change SKIP to any text you want
  String? nameSkipBtn;

  /// Style for text at SKIP button
  TextStyle? styleNameSkipBtn;

  /// Color for SKIP button
  Color? colorSkipBtn;

  /// Show or hide SKIP button
  bool? showSkipBtn;

  /// Rounded SKIP button
  double? borderRadiusSkipBtn;

  // ---------- PREV button ----------
  /// Render your own PREV button
  Widget? renderPrevBtn;

  /// Change PREV to any text you want
  String? namePrevBtn;

  /// Style for text at PREV button
  TextStyle? styleNamePrevBtn;

  /// Color for PREV button
  Color? colorPrevBtn;

  /// Width of view wrapper PREV button
  double? widthPrevBtn;

  /// Show or hide PREV button
  bool? showPrevBtn;

  /// Rounded PREV button
  double? borderRadiusPrevBtn;

  // ---------- DONE button ----------
  /// Render your own DONE button
  Widget? renderDoneBtn;

  /// Width of view wrapper DONE button
  double? widthDoneBtn;

  /// Fire when press DONE button
  Function? onDonePress;

  /// Change DONE to any text you want
  String? nameDoneBtn;

  /// Style for text at DONE button
  TextStyle? styleNameDoneBtn;

  /// Color for DONE button
  Color? colorDoneBtn;

  /// Rounded DONE button
  double? borderRadiusDoneBtn;

  /// Show or hide DONE button
  bool? isShowDoneBtn;

  // ---------- NEXT button ----------
  /// Render your own NEXT button
  Widget? renderNextBtn;

  /// Change NEXT to any text you want
  String? nameNextBtn;

  /// Show or hide NEXT button
  bool? showNextBtn;

  // ---------- Dot indicator ----------
  /// Show or hide dot indicator
  bool? showDotIndicator = true;

  /// Color for dot when passive
  Color? colorDot;

  /// Color for dot when active
  Color? colorActiveDot;

  /// Size of each dot
  double? sizeDot = 8.0;

  /// Type dots animation
  dotSliderAnimation? typeDotAnimation;

  // ---------- Tabs ----------
  /// List custom tabs
  List<Widget>? listCustomTabs;

  /// Notify when tab change completed
  Function? onTabChangeCompleted;

  /// Ref function go to specific tab index
  Function? refFuncGoToTab;

  // ---------- Behavior ----------
  /// Allow the slider to scroll
  bool? isScrollable;
  ScrollPhysics? scrollPhysics;

  /// Show or hide status bar
  bool? hideStatusBar;

  /// The way the vertical scrollbar should behave
  final scrollbarBehavior verticalScrollbarBehavior;

  // Constructor
  IntroSliderState({
    // List slides
    required this.slides,
    required this.backgroundColorAllSlides,

    // Skip button
    required this.renderSkipBtn,
    required this.widthSkipBtn,
    required this.onSkipPress,
    required this.nameSkipBtn,
    required this.styleNameSkipBtn,
    required this.colorSkipBtn,
    required this.showSkipBtn,
    required this.borderRadiusSkipBtn,

    // Prev button
    required this.widthPrevBtn,
    required this.showPrevBtn,
    required this.namePrevBtn,
    required this.renderPrevBtn,
    required this.styleNamePrevBtn,
    required this.colorPrevBtn,
    required this.borderRadiusPrevBtn,

    // Done button
    required this.renderDoneBtn,
    required this.widthDoneBtn,
    required this.onDonePress,
    required this.nameDoneBtn,
    required this.styleNameDoneBtn,
    required this.colorDoneBtn,
    required this.borderRadiusDoneBtn,
    required this.isShowDoneBtn,

    // Next button
    required this.nameNextBtn,
    required this.renderNextBtn,
    required this.showNextBtn,

    // Dot indicator
    required this.showDotIndicator,
    required this.colorDot,
    required this.colorActiveDot,
    required this.sizeDot,
    required this.typeDotAnimation,

    // Tabs
    required this.listCustomTabs,
    required this.onTabChangeCompleted,
    required this.refFuncGoToTab,

    // Behavior
    required this.isScrollable,
    required this.scrollPhysics,
    required this.hideStatusBar,
    required this.verticalScrollbarBehavior,
  });

  late TabController tabController;

  List<Widget>? tabs = [];
  List<Widget> dots = [];
  List<double?> sizeDots = [];
  List<double> opacityDots = [];
  List<ScrollController> scrollControllers = [];

  // For DOT_MOVEMENT
  double marginLeftDotFocused = 0;
  double marginRightDotFocused = 0;

  // For SIZE_TRANSITION
  double currentAnimationValue = 0;
  int currentTabIndex = 0;

  int lengthSlide = 0;

  @override
  void initState() {
    super.initState();

    lengthSlide = slides?.length ?? listCustomTabs?.length ?? 0;

    tabController = TabController(length: lengthSlide, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        currentTabIndex = tabController.previousIndex;
      } else {
        currentTabIndex = tabController.index;
      }
      currentAnimationValue = tabController.animation!.value;
      if (onTabChangeCompleted != null) {
        onTabChangeCompleted!(tabController.index);
      }
    });

    // Send reference function goToTab to parent
    if (refFuncGoToTab != null) {
      refFuncGoToTab!(goToTab);
    }

    // Dot animation
    sizeDot ??= 8.0;

    final initValueMarginRight = (sizeDot! * 2) * (lengthSlide - 1);
    typeDotAnimation ??= dotSliderAnimation.DOT_MOVEMENT;

    switch (typeDotAnimation!) {
      case dotSliderAnimation.DOT_MOVEMENT:
        for (var i = 0; i < lengthSlide; i++) {
          sizeDots.add(sizeDot);
          opacityDots.add(1.0);
        }
        marginRightDotFocused = initValueMarginRight;
        break;
      case dotSliderAnimation.SIZE_TRANSITION:
        for (var i = 0; i < lengthSlide; i++) {
          if (i == 0) {
            sizeDots.add(sizeDot! * 1.5);
            opacityDots.add(1.0);
          } else {
            sizeDots.add(sizeDot);
            opacityDots.add(0.5);
          }
        }
    }

    tabController.animation!.addListener(() {
      setState(() {
        switch (typeDotAnimation!) {
          case dotSliderAnimation.DOT_MOVEMENT:
            marginLeftDotFocused =
                tabController.animation!.value * sizeDot! * 2;
            marginRightDotFocused = initValueMarginRight -
                tabController.animation!.value * sizeDot! * 2;
            break;
          case dotSliderAnimation.SIZE_TRANSITION:
            if (tabController.animation!.value == currentAnimationValue) {
              break;
            }

            var diffValueAnimation =
                (tabController.animation!.value - currentAnimationValue).abs();
            final diffValueIndex =
                (currentTabIndex - tabController.index).abs();

            // When press skip button
            if (tabController.indexIsChanging &&
                (tabController.index - tabController.previousIndex).abs() > 1) {
              if (diffValueAnimation < 1.0) {
                diffValueAnimation = 1.0;
              }
              sizeDots[currentTabIndex] = sizeDot! * 1.5 -
                  (sizeDot! / 2) * (1 - (diffValueIndex - diffValueAnimation));
              sizeDots[tabController.index] = sizeDot! +
                  (sizeDot! / 2) * (1 - (diffValueIndex - diffValueAnimation));
              opacityDots[currentTabIndex] =
                  1.0 - (diffValueAnimation / diffValueIndex) / 2;
              opacityDots[tabController.index] =
                  0.5 + (diffValueAnimation / diffValueIndex) / 2;
            } else {
              if (tabController.animation!.value > currentAnimationValue) {
                // Swipe left
                sizeDots[currentTabIndex] =
                    sizeDot! * 1.5 - (sizeDot! / 2) * diffValueAnimation;
                sizeDots[currentTabIndex + 1] =
                    sizeDot! + (sizeDot! / 2) * diffValueAnimation;
                opacityDots[currentTabIndex] = 1.0 - diffValueAnimation / 2;
                opacityDots[currentTabIndex + 1] = 0.5 + diffValueAnimation / 2;
              } else {
                // Swipe right
                sizeDots[currentTabIndex] =
                    sizeDot! * 1.5 - (sizeDot! / 2) * diffValueAnimation;
                sizeDots[currentTabIndex - 1] =
                    sizeDot! + (sizeDot! / 2) * diffValueAnimation;
                opacityDots[currentTabIndex] = 1.0 - diffValueAnimation / 2;
                opacityDots[currentTabIndex - 1] = 0.5 + diffValueAnimation / 2;
              }
            }
            break;
        }
      });
    });

    // Dot indicator
    showDotIndicator ??= true;

    colorDot ??= Color(0x80000000);

    colorActiveDot ??= colorDot;

    isScrollable ??= true;

    scrollPhysics ??= ScrollPhysics();

    setupButtonDefaultValues();

    if (listCustomTabs == null) {
      renderListTabs();
    } else {
      tabs = listCustomTabs;
    }
  }

  void setupButtonDefaultValues() {
    // Skip button
    onSkipPress ??= () {
      if (!isAnimating(tabController.animation!.value)) {
        if (lengthSlide > 0) {
          tabController.animateTo(lengthSlide - 1);
        }
      }
    };

    showSkipBtn ??= true;

    styleNameSkipBtn ??= defaultBtnNameTextStyle;

    nameSkipBtn ??= 'SKIP';

    renderSkipBtn ??= Text(
      nameSkipBtn!,
      style: styleNameSkipBtn,
    );
    colorSkipBtn ??= defaultBtnColor;

    borderRadiusSkipBtn ??= defaultBtnBorderRadius;

    // Prev button
    if (showPrevBtn == null || showSkipBtn!) {
      showPrevBtn = false;
    }
    styleNamePrevBtn ??= defaultBtnNameTextStyle;

    namePrevBtn ??= 'PREV';

    renderPrevBtn ??= Text(
      namePrevBtn!,
      style: styleNamePrevBtn,
    );

    colorPrevBtn ??= defaultBtnColor;

    borderRadiusPrevBtn ??= defaultBtnBorderRadius;

    isShowDoneBtn ??= true;

    showNextBtn ??= true;

    // Done button
    onDonePress ??= () {};

    styleNameDoneBtn ??= defaultBtnNameTextStyle;

    nameDoneBtn ??= 'DONE';

    renderDoneBtn ??= Text(
      nameDoneBtn!,
      style: styleNameDoneBtn,
    );

    colorDoneBtn ??= defaultBtnColor;

    borderRadiusDoneBtn ??= defaultBtnBorderRadius;

    // Next button
    nameNextBtn ??= 'NEXT';

    renderNextBtn ??= Text(
      nameNextBtn!,
      style: styleNameDoneBtn,
    );
  }

  void goToTab(index) {
    if (index < tabController.length) {
      tabController.animateTo(index);
    }
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  // Checking if tab is animating
  bool isAnimating(value) {
    return tabController.animation!.value -
            tabController.animation!.value.truncate() !=
        0;
  }

  bool isRTLLanguage(language) {
    return rtlLanguages.contains(language);
  }

  @override
  Widget build(BuildContext context) {
    // Full screen view
    if (hideStatusBar == true) {
      SystemChrome.setEnabledSystemUIOverlays([]);
    }

    return Scaffold(
      body: DefaultTabController(
        length: lengthSlide,
        child: Stack(
          children: <Widget>[
            TabBarView(
              controller: tabController,
              physics: isScrollable!
                  ? scrollPhysics
                  : NeverScrollableScrollPhysics(),
              children: tabs!,
            ),
            renderBottom(),
          ],
        ),
      ),
      backgroundColor: backgroundColorAllSlides ?? Colors.transparent,
    );
  }

  Widget buildSkipButton() {
    if (tabController.index + 1 == lengthSlide) {
      return Container(width: MediaQuery.of(context).size.width / 4);
    } else {
      return TextButton(
        onPressed: onSkipPress as void Function()?,
        style: TextButton.styleFrom(
          primary: colorSkipBtn,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadiusSkipBtn!)),
        ),
        child: renderSkipBtn!,
      );
    }
  }

  Widget buildDoneButton() {
    return TextButton(
      onPressed: onDonePress as void Function()?,
      style: TextButton.styleFrom(
        primary: colorDoneBtn,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusDoneBtn!)),
      ),
      child: renderDoneBtn!,
    );
  }

  Widget buildPrevButton() {
    if (tabController.index == 0) {
      return Container(width: MediaQuery.of(context).size.width / 4);
    } else {
      return TextButton(
        onPressed: () {
          if (!isAnimating(tabController.animation!.value)) {
            tabController.animateTo(tabController.index - 1);
          }
        },
        style: TextButton.styleFrom(
          primary: colorPrevBtn,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadiusPrevBtn!)),
        ),
        child: renderPrevBtn!,
      );
    }
  }

  Widget buildNextButton() {
    return TextButton(
      onPressed: () {
        if (!isAnimating(tabController.animation!.value)) {
          tabController.animateTo(tabController.index + 1);
        }
      },
      style: TextButton.styleFrom(
        primary: colorDoneBtn,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusDoneBtn!)),
      ),
      child: renderNextBtn!,
    );
  }

  Widget renderBottom() {
    return Positioned(
      bottom: 10.0,
      left: 10.0,
      right: 10.0,
      child: Row(
        children: <Widget>[
          // Skip button
          Container(
            alignment: Alignment.center,
            width: showSkipBtn!
                ? widthSkipBtn ?? MediaQuery.of(context).size.width / 4
                : (showPrevBtn!
                    ? widthPrevBtn
                    : MediaQuery.of(context).size.width / 4),
            child: showSkipBtn!
                ? buildSkipButton()
                : (showPrevBtn! ? buildPrevButton() : Container()),
          ),

          // Dot indicator
          Flexible(
            child: showDotIndicator!
                ? Container(
                    child: Stack(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: renderListDots(),
                        ),
                        typeDotAnimation == dotSliderAnimation.DOT_MOVEMENT
                            ? Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: colorActiveDot,
                                      borderRadius:
                                          BorderRadius.circular(sizeDot! / 2)),
                                  width: sizeDot,
                                  height: sizeDot,
                                  margin: EdgeInsets.only(
                                      left: isRTLLanguage(
                                              Localizations.localeOf(context)
                                                  .languageCode)
                                          ? marginRightDotFocused
                                          : marginLeftDotFocused,
                                      right: isRTLLanguage(
                                              Localizations.localeOf(context)
                                                  .languageCode)
                                          ? marginLeftDotFocused
                                          : marginRightDotFocused),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  )
                : Container(),
          ),

          // Next, Done button
          Container(
            alignment: Alignment.center,
            width: widthDoneBtn ?? MediaQuery.of(context).size.width / 4,
            height: 50,
            child: tabController.index + 1 == lengthSlide
                ? isShowDoneBtn!
                    ? buildDoneButton()
                    : Container()
                : showNextBtn!
                    ? buildNextButton()
                    : Container(),
          ),
        ],
      ),
    );
  }

  List<Widget>? renderListTabs() {
    for (var i = 0; i < lengthSlide; i++) {
      final scrollController = ScrollController();
      scrollControllers.add(scrollController);
      tabs!.add(
        renderTab(
          scrollController,
          slides?[i].widgetTitle,
          slides?[i].title,
          slides?[i].maxLineTitle,
          slides?[i].styleTitle,
          slides?[i].marginTitle,
          slides?[i].widgetDescription,
          slides?[i].description,
          slides?[i].maxLineTextDescription,
          slides?[i].styleDescription,
          slides?[i].marginDescription,
          slides?[i].pathImage,
          slides?[i].widthImage,
          slides?[i].heightImage,
          slides?[i].foregroundImageFit,
          slides?[i].centerWidget,
          slides?[i].onCenterItemPress,
          slides?[i].backgroundColor,
          slides?[i].colorBegin,
          slides?[i].colorEnd,
          slides?[i].directionColorBegin,
          slides?[i].directionColorEnd,
          slides?[i].backgroundImage,
          slides?[i].backgroundImageFit,
          slides?[i].backgroundOpacity,
          slides?[i].backgroundOpacityColor,
          slides?[i].backgroundBlendMode,
        ),
      );
    }
    return tabs;
  }

  Widget renderTab(
    ScrollController scrollController,

    // Title
    Widget? widgetTitle,
    String? title,
    int? maxLineTitle,
    TextStyle? styleTitle,
    EdgeInsets? marginTitle,

    // Description
    Widget? widgetDescription,
    String? description,
    int? maxLineTextDescription,
    TextStyle? styleDescription,
    EdgeInsets? marginDescription,

    // Image
    String? pathImage,
    double? widthImage,
    double? heightImage,
    BoxFit? foregroundImageFit,

    // Center Widget
    Widget? centerWidget,
    Function? onCenterItemPress,

    // Background color
    Color? backgroundColor,
    Color? colorBegin,
    Color? colorEnd,
    AlignmentGeometry? directionColorBegin,
    AlignmentGeometry? directionColorEnd,

    // Background image
    String? backgroundImage,
    BoxFit? backgroundImageFit,
    double? backgroundOpacity,
    Color? backgroundOpacityColor,
    BlendMode? backgroundBlendMode,
  ) {
    final listView = ListView(
      controller: scrollController,
      children: <Widget>[
        Container(
          // Title
          margin: marginTitle ??
              EdgeInsets.only(top: 70.0, bottom: 50.0, left: 20.0, right: 20.0),
          child: widgetTitle ??
              Text(
                title ?? '',
                style: styleTitle ??
                    TextStyle(
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
                  pathImage,
                  width: widthImage ?? 200.0,
                  height: heightImage ?? 200.0,
                  fit: foregroundImageFit ?? BoxFit.contain,
                )
              : Center(child: centerWidget ?? Container()),
        ),

        // Description
        Container(
          margin:
              marginDescription ?? EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 50.0),
          child: widgetDescription ??
              Text(
                description ?? '',
                style: styleDescription ??
                    TextStyle(color: Colors.white, fontSize: 18.0),
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
                image: AssetImage(backgroundImage),
                fit: backgroundImageFit ?? BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  backgroundOpacityColor != null
                      ? backgroundOpacityColor
                          .withOpacity(backgroundOpacity ?? 0.5)
                      : Colors.black.withOpacity(backgroundOpacity ?? 0.5),
                  backgroundBlendMode ?? BlendMode.darken,
                ),
              ),
            )
          : BoxDecoration(
              gradient: LinearGradient(
                colors: backgroundColor != null
                    ? [backgroundColor, backgroundColor]
                    : [
                        colorBegin ?? Colors.amberAccent,
                        colorEnd ?? Colors.amberAccent
                      ],
                begin: directionColorBegin ?? Alignment.topLeft,
                end: directionColorEnd ?? Alignment.bottomRight,
              ),
            ),
      child: Container(
        margin: EdgeInsets.only(bottom: 60.0),
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

  List<Widget> renderListDots() {
    dots.clear();
    for (var i = 0; i < lengthSlide; i++) {
      dots.add(renderDot(sizeDots[i]!, colorDot, opacityDots[i]));
    }
    return dots;
  }

  Widget renderDot(double radius, Color? color, double opacity) {
    return Opacity(
      opacity: opacity,
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(radius / 2)),
        width: radius,
        height: radius,
        margin: EdgeInsets.only(left: radius / 2, right: radius / 2),
      ),
    );
  }
}
