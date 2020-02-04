import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stream_builder_example/models.dart';
import 'package:stream_builder_example/requests.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: StreamBuilder(
        stream: getNumbers(Duration(seconds: 1)),
        initialData: Number(0),
        builder: (context, stream) {
          if (stream.connectionState == ConnectionState.done) {
            return Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 20,
            );
          }
          if (stream.hasData) {
            return LikeCounter(stream.data.value);
          } else {
            return CircularProgressIndicator();
          }
        },
      )),
    );
  }
}

class LikeCounter extends StatelessWidget {
  static List<Color> colors = [
    Colors.green,
    Colors.purpleAccent,
    Colors.deepPurple,
    Colors.blueAccent,
    Colors.deepOrangeAccent
  ];
  final int num;

  LikeCounter(this.num);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: colors[num % colors.length],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.favorite, color: Colors.white),
          Text(
            " $num Likes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
