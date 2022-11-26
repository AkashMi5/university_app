import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title, domain, state, alphaCode, buttonText;
  final Image? image;

  const CustomDialog({
    Key? key,
    required this.title,
    required this.domain,
    required this.state,
    required this.alphaCode,
    required this.buttonText,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
            top: Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: const EdgeInsets.only(top: Consts.avatarRadius),
          decoration: BoxDecoration(
            color: Colors.cyan,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 20.0,
                offset: Offset(0.0, 20.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                domain,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                state,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                alphaCode,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 36.0),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black87)),
                      onPressed: () {
                        Navigator.of(context).pop(); // To close the dialog
                      },
                      child: const Text("Ok",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 20.0;
  static const double avatarRadius = 40.0;
}
