
import 'package:flutter/material.dart';

class CustomOverlayMessage extends StatelessWidget {

  final String message;
  final IconData icon;
  final Color iconColor;

  const CustomOverlayMessage({
    super.key, 
    required this.message, 
    required this.icon, 
    required this.iconColor
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 300,
            height: 150,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: iconColor,
                  size: 60,
                ),

                SizedBox(height: 10),

                Text(
                  message,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      );


      
  }
}


  void showCenterOverlay(
    BuildContext context, String message, IconData icon, Color iconColor, Duration duration) 
    {
      final overlay = Overlay.of(context);
      final overlayEntry = OverlayEntry(

        builder: (context) => CustomOverlayMessage(
          message: message, 
          icon: icon, 
          iconColor: iconColor
        ));

      overlay.insert(overlayEntry);

      Future.delayed(duration, () {
        overlayEntry.remove();
      });
  }