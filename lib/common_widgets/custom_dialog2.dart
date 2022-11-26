import 'package:flutter/material.dart';
import 'package:university_app/common_widgets/polkadots_card_canvas.dart';

class CustomDialog2 extends StatelessWidget {
  final String title, description;

  const CustomDialog2({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

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
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        Stack(
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
                  color: Colors.pinkAccent,
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
                          color: Colors.white),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                    const SizedBox(height: 12.0),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Close",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    )
                  ],
                )),
            Positioned(
                bottom: 20,
                left: 10,
                right: 10,
                top: 20,
                child: PolkadotsCardCanvas(Colors.white38))
          ],
        )
      ]),
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 20.0;
  static const double avatarRadius = 40.0;
}
