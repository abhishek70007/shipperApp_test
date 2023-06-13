import 'package:flutter/material.dart';
import 'package:shipper_app/responsive.dart';


class LiveasyLogoImage extends StatelessWidget {
  const LiveasyLogoImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(Responsive.isDesktop(context)?30:15,Responsive.isDesktop(context)?30:15),
      painter: LiveasyLogoImageDrawing(),
    );
  }
}

class LiveasyLogoImageDrawing extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width*0.5056520,size.height*0.5392038);
    path_0.lineTo(size.width*0.5018400,size.height*0.5368615);
    path_0.lineTo(size.width*0.4980400,size.height*0.5392192);
    path_0.lineTo(size.width*0.05775560,size.height*0.8123231);
    path_0.lineTo(size.width*0.007042240,size.height*0.7798154);
    path_0.lineTo(size.width*0.007042240,size.height*0.6392538);
    path_0.lineTo(size.width*0.5018440,size.height*0.3402627);
    path_0.lineTo(size.width*0.9929560,size.height*0.6392385);
    path_0.lineTo(size.width*0.9929560,size.height*0.7801077);
    path_0.lineTo(size.width*0.9496280,size.height*0.8121538);
    path_0.lineTo(size.width*0.5056520,size.height*0.5392038);
    path_0.close();

    Paint paint0Stroke = Paint()..style=PaintingStyle.stroke..strokeWidth=size.width*0.01408452;
    paint0Stroke.color=const Color(0xff3B6894).withOpacity(1.0);
    canvas.drawPath(path_0,paint0Stroke);

    Paint paint0Fill = Paint()..style=PaintingStyle.fill;
    paint0Fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_0,paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(size.width*0.5111840,size.height*0.8478577);
    path_1.lineTo(size.width*0.5077080,size.height*0.8459115);
    path_1.lineTo(size.width*0.5041960,size.height*0.8478077);
    path_1.lineTo(size.width*0.2887292,size.height*0.9641192);
    path_1.lineTo(size.width*0.1397064,size.height*0.8685923);
    path_1.lineTo(size.width*0.5075840,size.height*0.6399154);
    path_1.lineTo(size.width*0.8642840,size.height*0.8685731);
    path_1.lineTo(size.width*0.7188800,size.height*0.9640500);
    path_1.lineTo(size.width*0.5111840,size.height*0.8478577);
    path_1.close();

    Paint paint1Stroke = Paint()..style=PaintingStyle.stroke..strokeWidth=size.width*0.01408452;
    paint1Stroke.color=const Color(0xff3B6894).withOpacity(1.0);
    canvas.drawPath(path_1,paint1Stroke);

    Paint paint1Fill = Paint()..style=PaintingStyle.fill;
    paint1Fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_1,paint1Fill);

    Path path_2 = Path();
    path_2.moveTo(size.width*0.9929560,size.height*0.3667396);
    path_2.lineTo(size.width*0.9929560,size.height*0.5490654);
    path_2.lineTo(size.width*0.5038360,size.height*0.2433708);
    path_2.lineTo(size.width*0.5000000,size.height*0.2409719);
    path_2.lineTo(size.width*0.4961640,size.height*0.2433708);
    path_2.lineTo(size.width*0.007042240,size.height*0.5490654);
    path_2.lineTo(size.width*0.007042240,size.height*0.3667396);
    path_2.lineTo(size.width*0.5000000,size.height*0.04458308);
    path_2.lineTo(size.width*0.9929560,size.height*0.3667396);
    path_2.close();

    Paint paint2Stroke = Paint()..style=PaintingStyle.stroke..strokeWidth=size.width*0.01408452;
    paint2Stroke.color=const Color(0xff3B6894).withOpacity(1.0);
    canvas.drawPath(path_2,paint2Stroke);

    Paint paint2Fill = Paint()..style=PaintingStyle.fill;
    paint2Fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_2,paint2Fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

