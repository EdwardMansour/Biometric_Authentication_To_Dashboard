import 'package:biometric_dashboard/core/constants.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Function function;
  final double heightIn;
  final double widthIn;
  final String buttonName;
  final bool loading;
  final Color nameAndBoarderColor;
  final Color backGroundColor;
  const ButtonWidget({
    Key key,
    this.function,
    this.heightIn,
    this.widthIn,
    this.buttonName,
    this.loading = false,
    this.nameAndBoarderColor,
    this.backGroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        alignment: Alignment.center,
        height: heightIn,
        width: widthIn,
        decoration: BoxDecoration(
          color: backGroundColor,
          border: Border.all(
            color: nameAndBoarderColor,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Text(
                  buttonName,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: nameAndBoarderColor,
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ),
    );
  }
}
