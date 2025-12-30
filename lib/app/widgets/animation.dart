import 'dart:math';
import '../../exports.dart';

class SuccessSparkAnimation extends StatefulWidget {
  final String icon;

  const SuccessSparkAnimation({super.key, required this.icon});

  @override
  State<SuccessSparkAnimation> createState() => _SuccessSparkAnimationState();
}

class _SuccessSparkAnimationState extends State<SuccessSparkAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.width * 0.4,
      width: Get.width * 0.4,
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// Sparks
          CustomPaint(
            size: Size(Get.width * 0.4, Get.width * 0.4),
            painter: SparkPainter(_controller),
          ),

          /// Icon animation
          ScaleTransition(
            scale: Tween<double>(begin: 0.3, end: 1.0).animate(
              CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
            ),
            child: Image.asset(
              widget.icon,
              height: Get.width * 0.25,
              width: Get.width * 0.25,
            ),
          ),
        ],
      ),
    );
  }
}

class SparkPainter extends CustomPainter {
  final Animation<double> animation;

  SparkPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final progress = animation.value;

    /// -------- RING EFFECT --------
    final ringPaint = Paint()
      ..color = AppColors.appColor.withOpacity(0.25 * (1 - progress))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawCircle(
      center,
      size.width * 0.22 + (size.width * 0.18 * progress),
      ringPaint,
    );

    /// -------- RAY SPARKS --------
    final rayPaint = Paint()
      ..color = AppColors.appColor.withOpacity(0.8 * (1 - progress))
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    const rayCount = 12;

    for (int i = 0; i < rayCount; i++) {
      final angle = (i * 360 / rayCount) * pi / 180;

      final startRadius = size.width * 0.26;
      final endRadius = startRadius + (size.width * 0.12 * progress);

      final start = Offset(
        center.dx + startRadius * cos(angle),
        center.dy + startRadius * sin(angle),
      );

      final end = Offset(
        center.dx + endRadius * cos(angle),
        center.dy + endRadius * sin(angle),
      );

      canvas.drawLine(start, end, rayPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
