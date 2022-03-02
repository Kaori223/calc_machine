import 'package:calc_training/screens/test_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<DropdownMenuItem<int>> _memuItems = [];
  int _numberOfQuestions = 0;

  @override
  void initState() {
    super.initState();
    setMenuItems();
    //null safety(valueがnullableなので）
    _numberOfQuestions = _memuItems[0].value!;
  }

  void setMenuItems() {
    //１〜３はどれも一緒

    //1．addメソッド（普通）
//    _memuItems.add(DropdownMenuItem(value: 10, child: Text(10.toString()),));
//    _memuItems.add(DropdownMenuItem(value: 20, child: Text(20.toString()),));
//    _memuItems.add(DropdownMenuItem(value: 30, child: Text(30.toString()),));

    //２．addメソッド（Cascade Notation）
    _memuItems
      ..add(DropdownMenuItem(
        value: 10,
        child: Text(10.toString(),style: TextStyle(fontSize: 25.0),),
      ))
      ..add(DropdownMenuItem(
        value: 20,
        child: Text(20.toString(), style: TextStyle(fontSize: 25.0),),
      ))
      ..add(DropdownMenuItem(
        value: 30,
        child: Text(30.toString(), style: TextStyle(fontSize: 25.0),),
      ));

    //３．Listにダイレクトに値代入
//    _memuItems =
//    [DropdownMenuItem(value: 10, child: Text(10.toString()),),
//    DropdownMenuItem(value: 10, child: Text(10.toString()),),
//    DropdownMenuItem(value: 10, child: Text(10.toString()),)];
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    print("ヨコ幅の論理ピクセル : $screenWidth");
    print("タテ幅の論理ピクセル : $screenHeight");

    return Scaffold(
      body: SafeArea(
        child: Padding(
          //画面全体に余白を付けたい場合
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Image.asset("assets/images/image_title.png"),
                const SizedBox(
                  height: 50.0,
                ),
                const Text(
                  "問題数を選択して「スタート」ボタンを押してください",
                  style: TextStyle(fontSize: 20.0),
                ),
                const SizedBox(
                  height: 75.0,
                ),
                DropdownButton(
                  items: _memuItems,
                  value: _numberOfQuestions,
                  //null safety（T?なので型指定必要）
                  //final ValueChanged<T?>? onChanged
                  //https://api.flutter.dev/flutter/material/DropdownButton-class.html
                  onChanged: (int? value) => changeDropdownItem(value!),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(bottom: 20.0), //ボタンの底辺だけに余白をつけたい場合
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.skip_next),
                      label: Text("スタート", style: TextStyle(fontSize: 20.0),),
                      onPressed: () => startTestScreen(context),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.brown,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          )
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  changeDropdownItem(int value) {
    setState(() {
      _numberOfQuestions = value;
    });
  }

  startTestScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context)
      => TestScreen(number0fQuestions: _numberOfQuestions,))
        );

  }
}
