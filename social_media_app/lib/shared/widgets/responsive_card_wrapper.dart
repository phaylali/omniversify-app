import 'package:flutter/material.dart';

class ResponsiveCardWrapper extends StatelessWidget {
  final Widget child;

  const ResponsiveCardWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width > 600
              ? MediaQuery.of(context).size.width * 0.6
              : MediaQuery.of(context).size.width * 0.9,
        ),
        child: child,
      ),
    );
  }
}
