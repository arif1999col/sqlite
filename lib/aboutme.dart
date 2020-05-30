import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './screens/home_screen.dart';

class Aboutme extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
          ),
          title: Text("Profil"),
          centerTitle: true,
        ),
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image(
                    image: NetworkImage(
                        "https://scontent.fdps5-1.fna.fbcdn.net/v/t1.0-9/42434997_298964220929963_2649248884596932608_n.jpg?_nc_cat=106&_nc_sid=85a577&_nc_eui2=AeGgLEriLWPuQrOcnl4SAnw3_WAVrzkqYWz9YBWvOSphbDynDCbO0ZXDGU7-mWc0zbQ7oDOxJEatNzVXRE3g8gQw&_nc_ohc=0YHGEMKPnEEAX9uLj4k&_nc_ht=scontent.fdps5-1.fna&oh=7dfff98869d9d409f78741e27428f120&oe=5EF52E33"),
                    width: 150,
                    height: 150,
                  ),
                ),
                Text(
                  "Arif Suryanto",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    height: 2.0,
                  ),
                ),
                Text(
                  "IG : Mochi.aet",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.only(top: 20, right: 20, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ContainIcon(0, "BALI", Icons.home, Colors.red),
                          ContainIcon(
                              12, "Japaz Roks", Icons.library_music, Colors.red),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          ContainIcon(0, "Drawing Art", Icons.history,
                              Colors.red),
                          ContainIcon(12, "Undiksha", Icons.local_activity, Colors.red),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}

//container dari kotak yang berisi icon
class ContainIcon extends StatelessWidget {
  final double atas;
  final String isi;
  final IconData icon;
  final Color warna;
  const ContainIcon(this.atas, this.isi, this.icon, this.warna);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 20, top: atas),
        padding: EdgeInsets.only(top: 20),
        width: 130,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          border: Border.all(
            width: 3,
            color: Colors.red,
          ),
        ),
        child: Column(
          children: <Widget>[
            Icon(
              icon,
              size: 40,
              color: warna,
            ),
            Container(
              color: Colors.red,
              margin: EdgeInsets.only(top: 24),
              width: 125,
              height: 30,
              child: TextBox(isi),
            ),
          ],
        ));
  }
}

//untuk text di dalam kotak
class TextBox extends StatelessWidget {
  final String isi;
  const TextBox(this.isi);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        isi,
        style: TextStyle(height: 1.3, fontSize: 18, color: Colors.white),
      ),
    );
  }
}
