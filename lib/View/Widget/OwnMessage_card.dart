import 'package:flutter/material.dart';

class OwnMessageCard extends StatelessWidget {
  final String message;
  final String time;

  OwnMessageCard({required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width - 45),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          color: const Color(0xffdcf8c6),
          child: Stack(
            children: [
               Padding(
                padding:
                    EdgeInsets.only(left: 10, right: 30, top: 5, bottom: 20),
                child: Text(
                  message,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Positioned(
                  bottom: 2,
                  right: 10,
                  child: Row(
                    children: [
                      Text(
                       time,
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.done_all,
                        size: 20,
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
