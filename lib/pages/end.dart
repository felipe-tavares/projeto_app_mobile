import 'package:flutter/material.dart';
import 'dart:math' as math;

class Timer extends StatefulWidget {
  final String time;

  const Timer({Key key, this.time}) : super(key: key);

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> with TickerProviderStateMixin {
  AnimationController controller;

  // bool isPlaying = false;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    if(duration.inDays == 0){
      return '${(duration.inHours % 24).toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    return '${(duration.inDays % 30).toString().padLeft(3, '0')}, ${(duration.inHours % 24).toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }
  //

  @override
  void initState() {
    String diatual = DateTime.now().toString();
    String hour = (widget.time).substring(11,13);
    String minute = (widget.time).substring(14,16);
    String day = (widget.time).substring(8,10);
    String month = (widget.time).substring(5,7);
    String houratual = (diatual).substring(11,13);
    String minuteatual = (diatual).substring(14,16);
    String dayatual = (diatual).substring(8,10);
    String monthatual = (diatual).substring(5,7);
    //print(month + ' ' + day + ' ' + hour + ' ' + minute);
    //print(monthatual + ' ' + dayatual + ' ' + houratual + ' ' + minuteatual);
    //12 meses, 30 dias, 24 horas, 60 minutos
    //o maior vai ser o time do widget, então, subtrair o atual dele
    int mes = int.parse(month) - int.parse(monthatual);
    int dia;
    int hora;
    int minuto;
    //quantidade de dias varia por diferença de mes, a cada mes de diferença, incrementa 30 dias 22/06 10/08 -> 8-6=2, 2-1=1 30+10-22=18, 18+1*30
    if(int.parse(day) - int.parse(dayatual) < 0){//se dia atual > dia passado, decrementa mes e acrescenta 30 dias (ajustar dps)
      mes -= 1;
      dia = (int.parse(day)+30) - int.parse(dayatual);
    }else{
      dia = int.parse(day) - int.parse(dayatual);
    }
    dia+=mes*30;
    if(int.parse(hour) - int.parse(houratual) < 0){//se hora negativa, 08 - 20, decrementa dia e acrescenta 24 horas a hora escolhida
      dia -= 1;
      hora = (int.parse(hour)+24) - int.parse(houratual);
    }else{
      hora = int.parse(hour) - int.parse(houratual);
    }
    if(int.parse(minute) - int.parse(minuteatual) < 0){//se minuto negativo, 30 - 55, decrementa hora e acrescenta 60 minutos ao minuto escolhido
      hora -= 1;
      minuto = (int.parse(minute)+60) - int.parse(minuteatual);
    }else{
      minuto = int.parse(minute) - int.parse(minuteatual);
    }
    if(mes.isNegative || dia.isNegative || hora.isNegative || minuto.isNegative){
      print("Data invalida!");
    }else{
      super.initState();
      controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 59, minutes: minuto, hours: hora, days: dia),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //ThemeData themeData = Theme.of(context);
    controller.reverse(
        from: controller.value == 0.0
            ? 1.0
            : controller.value);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 30, left: 30, top: 150),
                  child: Align(
                    alignment: FractionalOffset.topCenter,
                    child: Container(
                        child: Text(
                          "COMPRA \nBEM SUCEDIDA!",
                          textAlign: TextAlign.left,

                          style: TextStyle(
                            fontFamily: 'Oswald',
                            fontSize: 25,
                            color: Colors.red,
                          ),
                        )
                    ),
                  ),
                )
            ),

            Expanded(
              child: Align(
                alignment: FractionalOffset.center,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: AnimatedBuilder(
                          animation: controller,
                          builder: (BuildContext context, Widget child) {
                            return CustomPaint(
                                painter: TimerPainter(
                                  animation: controller,
                                  backgroundColor: Colors.white,
                                  color: Colors.red,
                                ));
                          },
                        ),
                      ),
                      Align(
                        alignment: FractionalOffset.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Tempo de entrega:",
                              style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            AnimatedBuilder(
                                animation: controller,
                                builder: (BuildContext context, Widget child) {
                                  return Text(
                                    timerString,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize: 40,
                                      color: Colors.white,
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
            )
          ],
        ),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
