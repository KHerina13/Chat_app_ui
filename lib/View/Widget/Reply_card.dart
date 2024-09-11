import 'package:flutter/material.dart';

class ReplayCard extends StatelessWidget {
  final String message;
  final String time;

  ReplayCard({required this.time, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
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
                    EdgeInsets.only(left: 8, right: 50, top: 5, bottom: 20),
                child: Text(
                  message,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Text(
                  time,
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
