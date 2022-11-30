import 'package:flutter/material.dart';
import 'package:ticket_material/mask_ticket_painter.dart';

///Main class of plugin, that combine [MaskTicketPainter] as mask between
///left an right part of ticket.
class TicketMaterial extends StatefulWidget {
  final int flexLefSize;
  final int flexMaskSize;
  final int flexRightSize;
  final Color colorBackground;
  final Color colorShadow;
  final double shadowSize;
  final double radiusCircle;
  final double radiusBorder;
  final double marginBetweenCircles;
  final double height;
  final Widget leftChild;
  final Widget rightChild;
  final Function()? tapHandler;
  final bool useAnimationScaleOnTap;
  final Clip clipBehavior;

  const TicketMaterial({
    this.flexLefSize = 70,
    this.flexMaskSize = 5,
    this.flexRightSize = 20,
    this.radiusCircle = 4,
    this.marginBetweenCircles = 3,
    required this.height,
    required this.leftChild,
    required this.rightChild,
    required this.colorBackground,
    this.colorShadow = Colors.grey,
    this.shadowSize = 1.5,
    this.radiusBorder = 0,
    this.tapHandler,
    this.useAnimationScaleOnTap = true,  this.clipBehavior = Clip.antiAlias,
  });

  @override
  _TicketMaterialState createState() => _TicketMaterialState(height);
}

class _TicketMaterialState extends State<TicketMaterial>
    with SingleTickerProviderStateMixin {
  final double _height;
  final _width = double.infinity;

  _TicketMaterialState(this._height);

  ///This trigger immediately before onTap event.
  ///Launch animation of changing scale ticket(reducing size of ticket).
  void _tapUp(TapUpDetails details) {
    if (widget.tapHandler != null) {
      widget.tapHandler!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: _tapUp,
      child: SizedBox(
        width: _width,
        height: _height,
        child: Row(
          children: <Widget>[
            Flexible(
                flex: widget.flexLefSize,
                child: Container(clipBehavior: widget.clipBehavior,
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: widget.colorBackground,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(widget.radiusBorder),
                        bottomLeft: Radius.circular(widget.radiusBorder),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: widget.colorShadow,
                          blurRadius: 0.5,
                          offset: Offset(-0.5, widget.shadowSize),
                        ),
                      ]),
                  child: widget.leftChild,
                )),
            Flexible(
              flex: widget.flexMaskSize,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.transparent,
                child: CustomPaint(
                  painter: MaskTicketPainter(
                      radiusCircle: widget.radiusCircle,
                      marginBetweenCircles: widget.marginBetweenCircles,
                      colorBg: widget.colorBackground,
                      colorShadow: widget.colorShadow,
                      shadowSize: widget.shadowSize),
                ),
              ),
            ),
            Flexible(
                flex: widget.flexRightSize,
                child: Container(
                  clipBehavior: widget.clipBehavior,
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: widget.colorBackground,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(widget.radiusBorder),
                        topRight: Radius.circular(widget.radiusBorder),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: widget.colorShadow,
                            blurRadius: 0.5,
                            offset: Offset(0.5, widget.shadowSize)),
                      ]),
                  child: widget.rightChild,
                ))
          ],
        ),
      ),
    );
  }
}
