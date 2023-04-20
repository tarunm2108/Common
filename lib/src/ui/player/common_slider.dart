import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_code/app_consts/extension/text_style_extension.dart';
import 'package:my_code/src/ui/player/gradient_track.dart';

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;
  final Color? textColor;
  final double? sliderStroke;

  const SeekBar({
    Key? key,
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
    this.textColor,
    this.sliderStroke,
  }) : super(key: key);

  @override
  State createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double? _dragValue;
  late SliderThemeData _sliderThemeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 2.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SliderTheme(
          data: _sliderThemeData.copyWith(
            thumbShape: HiddenThumbComponentShape(),
            activeTrackColor: Colors.blue.shade100,
            inactiveTrackColor: Colors.grey.shade300,
            trackShape: const RoundedRectSliderTrackShape(),
            trackHeight: 3,
          ),
          child: ExcludeSemantics(
            child: Slider(
              min: 0.0,
              max: widget.duration.inMilliseconds.toDouble(),
              value: min(widget.bufferedPosition.inMilliseconds.toDouble(),
                  widget.duration.inMilliseconds.toDouble()),
              onChanged: (value) {
                setState(() {
                  _dragValue = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(Duration(milliseconds: value.round()));
                }
              },
              onChangeEnd: (value) {
                if (widget.onChangeEnd != null) {
                  widget.onChangeEnd!(Duration(milliseconds: value.round()));
                }
                _dragValue = null;
              },
            ),
          ),
        ),
        SliderTheme(
          data: _sliderThemeData.copyWith(
              inactiveTrackColor: Colors.transparent,
              trackShape: const GradientRectSliderTrackShape(
                  gradient: LinearGradient(colors: [
                Color(0xff36B6CD),
                Color(0xffAE37AA),
              ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
              trackHeight: 3,
              thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 5.0, elevation: 6)),
          child: Slider(
            min: 0.0,
            thumbColor: Colors.white,
            max: widget.duration.inMilliseconds.toDouble(),
            value: min(_dragValue ?? widget.position.inMilliseconds.toDouble(),
                widget.duration.inMilliseconds.toDouble()),
            onChanged: (value) {
              setState(() {
                _dragValue = value;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(Duration(milliseconds: value.round()));
              }
            },
            onChangeEnd: (value) {
              if (widget.onChangeEnd != null) {
                widget.onChangeEnd!(Duration(milliseconds: value.round()));
              }
              _dragValue = null;
            },
          ),
        ),
        Positioned(
            right: 16.0,
            left: 16.0,
            //top: 0,
            bottom: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTime(widget.position, widget.textColor),
                _buildTime(widget.duration, widget.textColor),
              ],
            )),
        /* Positioned(
          right: 16.0,
          bottom: 0.0,
          child: Text(
              RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                  .firstMatch("$_remaining")
                  ?.group(1) ??
                  '$_remaining',
              style: const TextStyle().normal.copyWith(
                fontSize: 12
              )),
        ),*/
      ],
    );
  }

  Widget _buildTime(Duration duration, Color? textColor) {
    //final hours =twoDigits(model.duration.inHours);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          duration.inMinutes.remainder(60).toString().padLeft(2, '0'),
          style: const TextStyle().medium.copyWith(
              fontSize: 16, color: textColor ?? const Color(0xff043645)),
        ),
        Text(
          ' : ',
          style: const TextStyle().medium.copyWith(
              fontSize: 16, color: textColor ?? const Color(0xff043645)),
        ),
        Text(
          duration.inSeconds.remainder(60).toString().padLeft(2, '0'),
          style: const TextStyle().medium.copyWith(
              fontSize: 16, color: textColor ?? const Color(0xff043645)),
        ),
      ],
    );
  }

//Duration get _remaining => widget.duration - widget.position;
}

class HiddenThumbComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {}
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}

void showSliderDialog({
  required BuildContext context,
  required String title,
  required int divisions,
  required double min,
  required double max,
  String valueSuffix = '',
  required double value,
  required Stream<double> stream,
  required ValueChanged<double> onChanged,
}) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: StreamBuilder<double>(
        stream: stream,
        builder: (context, snapshot) => SizedBox(
          height: 100.0,
          child: Column(
            children: [
              Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                  style: const TextStyle().bold.copyWith(fontSize: 24)),
              Slider(
                min: min,
                max: max,
                activeColor: const Color(0xff36B6CD),
                inactiveColor: const Color(0x4036B6CD),
                value: snapshot.data ?? value,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
