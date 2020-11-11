/*
 * rflutter_alert
 * Created by Ratel
 * https://ratel.com.tr
 *
 * Copyright (c) 2018 Ratel, LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */
import 'dart:io';

import 'package:flutter/material.dart';

import 'alert_style.dart';
import 'animation_transition.dart';
import 'constants.dart';
import 'dialog_button.dart';
import 'package:http/http.dart' as http;


/// Main class to create alerts.
///
/// You must call the "show()" method to view the alert class you have defined.
class Alert {
  final BuildContext context;
  final AlertType type;
  final AlertStyle style;
  final Image image;
  final String title;
  final String desc;
  final Widget content;
  final List<DialogButton> buttons;
  final Function closeFunction;
  final TextEditingController textFieldController;
  final String acessToken;


  /// Alert constructor
  ///
  /// [context], [title] are required.
  Alert({
    @required this.context,
    this.type,
    this.style = const AlertStyle(),
    this.image,
    @required this.title,
    this.desc,
    this.content,
    this.buttons,
    this.closeFunction,
    this.textFieldController,
    this.acessToken
  });

  /// Displays defined alert window
  Future<bool> show() async {
    return await showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return _buildDialog();
      },
      barrierDismissible: style.isOverlayTapDismiss,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: style.overlayColor,
      transitionDuration: style.animationDuration,
      transitionBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          ) =>
          _showAnimation(animation, secondaryAnimation, child),
    );
  }

  /// Displays defined alert window
  Future<bool> sendWishesAlert() async {
    return await showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return _sendGreeting();
      },
      barrierDismissible: style.isOverlayTapDismiss,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: style.overlayColor,
      transitionDuration: style.animationDuration,
      transitionBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          ) =>
          _showAnimation(animation, secondaryAnimation, child),
    );
  }

// // Will be added in next version.
//   void dismiss() {
//     Navigator.pop(context);
//   }

  // Alert dialog content widget
  Widget _buildDialog() {
    return Center(
      child: ConstrainedBox(
        constraints: style.constraints ?? BoxConstraints.expand(width: double.infinity, height: double.infinity),
        child: Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              backgroundColor: style.backgroundColor ?? Theme.of(context).dialogBackgroundColor,
              shape: style.alertBorder ?? _defaultShape(),
              titlePadding: EdgeInsets.all(0.0),
              title: Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _getCloseButton(),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            20, (style.isCloseButton ? 0 : 20), 20, 0),
                        child: Column(
                          children: <Widget>[
                            _getImage(acessToken),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              title,
                              style: style.titleStyle,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: desc == null ? 5 : 10,
                            ),
                            desc == null
                                ? Container()
                                : Text(
                              desc,
                              style: style.descStyle,
                              textAlign: TextAlign.center,
                            ),
                            content == null ? Container() : content,
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              contentPadding: style.buttonAreaPadding,
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _getButtons(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Alert dialog content widget
  Widget _sendGreeting() {
    TextStyle style1 = TextStyle(fontFamily: 'Montserrat' , fontSize: 20.0);
    final sendGreetings = TextField(
      controller: textFieldController,
      obscureText: false,
      style: style1,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        // contentPadding: const EdgeInsets.all(20.0),
        hintText: 'Send your wishes',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        contentPadding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
      ),
    );

    // Card(
    //   child: InkWell(
    //     child: Text('This is some text in a card'),
    //     onTap: () => showDialog(
    //       context: context,
    //       builder: (context) => AlertDialog(
    //         content: Stack(
    //           alignment: Alignment.center,
    //           children: <Widget>[
    //             Image.asset(
    //               'Path to image',
    //               height: 200,
    //               fit: BoxFit.cover,
    //             ),
    //             Text(
    //               'This Is Some Text',
    //               style: TextStyle(
    //                 fontSize: 24,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    return Center(
        child: ConstrainedBox(
          constraints: style.constraints ?? BoxConstraints.expand(width: double.infinity, height: double.infinity),
          child: Center(
            child: SingleChildScrollView(
              child: AlertDialog(
                backgroundColor: style.backgroundColor ?? Theme.of(context).dialogBackgroundColor,
                shape: style.alertBorder ?? _defaultShape(),
                titlePadding: EdgeInsets.all(0.0),
                title: Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _getCloseButton(),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              20, (style.isCloseButton ? 0 : 20), 20, 0),
                          child: Column(
                            children: <Widget>[
                              _getImage(acessToken),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                title,
                                style: style.titleStyle,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: desc == null ? 5 : 10,
                              ),
                              desc == null
                                  ? Container()
                                  : Text(
                                desc,
                                style: style.descStyle,
                                textAlign: TextAlign.center,
                              ),
                              content == null ? Container() : content,
                              SizedBox(
                                height: desc == null ? 5 : 10,
                              ),
                              sendGreetings,
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                contentPadding: style.buttonAreaPadding,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _getButtons(),
                ),
              ),
            ),
          ),
        ),
    );
  }

  // Returns alert default border style
  ShapeBorder _defaultShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: BorderSide(
        color: Colors.blueGrey,
      ),
    );
  }

// Returns the close button on the top right
  Widget _getCloseButton() {
    return style.isCloseButton
        ? Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
      child: Container(
        alignment: FractionalOffset.topRight,
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'Assets/close.png',
              ),
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                closeFunction();
              },
            ),
          ),
        ),
      ),
    )
        : Container();
  }

  // Returns defined buttons. Default: Cancel Button
  List<Widget> _getButtons() {
    List<Widget> expandedButtons = [];
    if (buttons != null) {
      buttons.forEach(
            (button) {
          var buttonWidget = Padding(
            padding: const EdgeInsets.only(left: 2, right: 2),
            child: button,
          );
          if (button.width != null && buttons.length == 1) {
            expandedButtons.add(buttonWidget);
          } else {
            expandedButtons.add(Expanded(
              child: buttonWidget,
            ));
          }
        },
      );
    } else {
      expandedButtons.add(
        Expanded(
          child: DialogButton(
            child: Text(
              "CANCEL",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      );
    }

    return expandedButtons;
  }

// Returns alert image for icon
  Widget _getImage(String accessToken) {
    Widget response = image ?? Container();
    switch (type) {
      case AlertType.success:
        response = Image.asset(
          '$kImagePath/icon_success.png',
          package: 'rflutter_alert',
        );
        break;
      case AlertType.error:
        response = Image.asset(
          '$kImagePath/icon_error.png',
          package: 'rflutter_alert',
        );
        break;
      case AlertType.info:
        response = Image.asset(
          '$kImagePath/icon_info.png',
          package: 'rflutter_alert',
        );
        break;
      case AlertType.warning:
        response = Image.asset(
          'Assets/profile_img.png',
          package: 'rflutter_alert',
        );
        break;
      case AlertType.profile:
        // response = Image.asset(
        //   'Assets/profile_img.png',
        //   fit: BoxFit.contain,
        // );
        // response = Image.network("https://aid.cognizant.com/assets/img/profile/fbd976b9-f3f6-416d-88d6-60b05caa6d31.jpg");
        // final client = new HttpClient()..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
        return Image.network("https://aid.cognizant.com/assets/img/profile/fbd976b9-f3f6-416d-88d6-60b05caa6d31.jpg", headers: {"Authorization": "Bearer $accessToken"},);

        break;
      case AlertType.none:
        response = Container();
        break;
    }
    return response;
  }

// Shows alert with selected animation
  _showAnimation(animation, secondaryAnimation, child) {
    if (style.animationType == AnimationType.fromRight) {
      return AnimationTransition.fromRight(
          animation, secondaryAnimation, child);
    } else if (style.animationType == AnimationType.fromLeft) {
      return AnimationTransition.fromLeft(animation, secondaryAnimation, child);
    } else if (style.animationType == AnimationType.fromBottom) {
      return AnimationTransition.fromBottom(
          animation, secondaryAnimation, child);
    } else if (style.animationType == AnimationType.grow) {
      return AnimationTransition.grow(animation, secondaryAnimation, child);
    } else if (style.animationType == AnimationType.shrink) {
      return AnimationTransition.shrink(animation, secondaryAnimation, child);
    } else {
      return AnimationTransition.fromTop(animation, secondaryAnimation, child);
    }
  }
}
