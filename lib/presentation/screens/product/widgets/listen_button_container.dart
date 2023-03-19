import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/presentation/misc/log.dart';
import 'package:womanly_mobile/presentation/screens/product/product_state.dart';
import 'package:womanly_mobile/presentation/screens/product/widgets/custom_app_bar.dart';

class ListenButtonContainer extends StatelessWidget {
  final Book book;
  final Widget child;
  const ListenButtonContainer(this.book, this.child, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomAppBar(title: book.name),
        Padding(
          padding: EdgeInsets.only(
              left: 8, top: 4 + MediaQuery.of(context).padding.top),
          child: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              Log.dialog(context, "Navigation pop");
            },
            icon: Image.asset(
              "assets/images/icons/arrow_left.png",
              width: 24,
              height: 24,
            ),
          ),
        ),
        PositionedContainer(MediaQuery.of(context).size.width, child),
      ],
    );
  }
}

class PositionedContainer extends StatelessWidget {
  final double screenWidth;
  final Widget child;
  const PositionedContainer(this.screenWidth, this.child, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonPosition =
        context.select<ProductState, double>((state) => state.buttonPosition);

    return Positioned(
      top: buttonPosition,
      left: 16,
      width: screenWidth - 32,
      child: AnimatedOpacity(
        opacity: buttonPosition < 0 ? 0 : 1,
        duration: const Duration(seconds: 1),
        child: child,
      ),
    );
  }
}
