

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmers_market/home_screens/navigation_screens/myhome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'home_screens/main_view.dart';

void main() {
  runApp(product());
}

// a function to return url
DocumentSnapshot checkurl(List<DocumentSnapshot> lis, String hell) {
  //print(lis);
  // print(hell);

  for (int i = 0; i < lis.length; i++) {
    if (lis[i].id.toString().compareTo(hell) == 0) {
      // print(lis[i][1]);
      return lis[i];
    }
  }

  return null;
}

/*remove later just return not found varibale from database
DocumentSnapshot notfound(List lis) {
  //print(lis);
  // print(hell);

  for (int i = 0; i < lis.length; i++) {
    if (lis[i].id.toString().compareTo("Not Found") == 0) {
      // print(lis[i][1]);
      return lis[i];
    }
  }

  return null;
}
*/
class product extends StatelessWidget {

  @override
  static List li;
  static var he = "";
  static var producers;
  static String type;
  static List<DocumentSnapshot> documents;
  static List<DocumentSnapshot> image;
  static int selectedIndex;
  static List<bool> value = new List<bool>.filled(documents.length, false,
      growable: false);
  static String category;
  Widget build(BuildContext context) {
    //  MyHomePage.list = list;
    _MyHomePageState.hello = he;
    _MyHomePageState.list = li;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: new Text(
            he,
            style: new TextStyle(color: Colors.white),
          ),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainView()),
              );
            },
          ),
        ),
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
  //_MyHomePageState _myHomePageState = new _MyHomePageState();

}


List<String> images1 = [
  "https://5.imimg.com/data5/VK/YR/QZ/SELLER-89932137/savoy-cabbage-500x500.jpg",
  "https://cdn-prod.medicalnewstoday.com/content/images/articles/284/284823/one-big-cabbage.jpg"
];
List<String> images2 = [
  "https://cdn.harvesttotable.com/htt/2009/01/23181459/Cabbage-bigstock-Salad-Species-That-Includes-Se-251274103-scaled.jpg",
  "https://extension.umd.edu/sites/extension.umd.edu/files/styles/optimized/public/2021-01/Veg_crop_white-cabbage-2705228_1920_Pixabay.jpg?itok=WhjxU0Ti"
];
bool _value = true;

BoxDecoration myBoxDecoration(Color color, Color bg) {
  return BoxDecoration(
    color: bg,
    border: Border.all(
      color: color, //                   <--- border color
      width: 2.0,
    ),
  );
}

class _MyHomePageState extends State<MyHomePage> {
  static var hello = "";
  static List list;
  String category = product.category;
  var producers=product.producers;
  String type = product.type;
  List<DocumentSnapshot> documents=product.documents;
  List<DocumentSnapshot> image= product.image;
  List<bool> value = product.value;
  PageController pageController;
  int currentPage;
  int selectedIndex=product.selectedIndex;
  List<String> images=images1;
  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);

  }

  Future<void> getData2() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


    var vege = await FirebaseFirestore.instance.collection('Categories').doc
      (category).collection("Items").doc
      (type).collection("Producers");

    final doc = await vege.get();
    documents=doc.docs;

    vege = await FirebaseFirestore.instance.collection('Categories').doc
      (category).collection("Items").doc
      (type).collection("Producers").doc(documents[selectedIndex].id).collection("Images");
    final doc2 = await vege.get();
    image=doc2.docs;



  }
  List<Widget> circles(imagesLength,currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
//print(list);
    print("++++++++++++++++++++");
    print(image.length);


    //DocumentSnapshot url = checkurl(list, hello);

    //"https://previews.123rf.com/images/kaymosk/kaymosk1804/kaymosk180400005/99776312-error-404-page-not-found-error-with-glitch-effect-on-screen-vector-illustration-for-your-design.jpg"; //checkurl(list, hello);
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.green,
        //leading: IconButton(
        //icon: Icons.arrow_back,
        //onPressed: () {},
        //),
        elevation: 0.7,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.search,
                size: 26.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.share,
                size: 26.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.shopping_cart,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          //adding: EdgeInsets.zero,
          children: <Widget>[
            Row(
              children: <Widget>[

                Container(
                  padding: EdgeInsets.all(3),
                  color: Colors.green[300],
                  child: Center(
                    child: Text('Store'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(3),
                  child: Center(
                    child: Text(
                      type,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(1),
                  child: Text(
                    'MRP: ',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(3),
                  child: Text(
                    "€ "+documents[selectedIndex].get("Price").toString(),
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),


                SizedBox(
                  width: 7,
                ),

              ],
            ),
            Container(
              padding: EdgeInsets.all(2),
              child: Text(
                '(Inclusive of all taxes)',
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(2, 1, 2, 1),
                  color: Colors.green[100],
                  child: Text(
                    '3.5 *',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(1),
                    child: Text(
                      '10 ratings & 1 review  >',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              ],
            ),

            SizedBox(
              height: 10,
            ),
            Center(

            ),
            Divider(
              height: 28,
              color: Colors.grey,
            ),
          Column(
            children:[SizedBox(height: 200, width: MediaQuery.of(context).size
                .width,
                child:

                PageView.builder(
                itemCount: image.length,
                pageSnapping: true,
                controller: pageController,
                onPageChanged: (page) {
                  print(page);
                  setState(() {
                  currentPage = page;
                  });
                },
                itemBuilder: (context,pagePosition){
                  return Container(
                      margin: EdgeInsets.all(10),
                      child: Image.network(image[pagePosition].get("url")));
                }

            )),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: circles(images.length,currentPage)
              )

            ]),

            Container(
              padding: EdgeInsets.all(3),
              child: Text(
                'Farmers:',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Column(
                children:[SizedBox(height: 200, width: MediaQuery.of(context).size
                    .width,
                    child:

                    ListView.builder(
                        itemCount: documents.length,

                       controller: pageController,

                        itemBuilder: (context,pagePosition){

                        return ListTile(
                          title: Text(documents[pagePosition].get("Name")),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          tileColor:selectedIndex == pagePosition ? Colors
                              .lightGreen[100]
                              : null,
                          onTap: () async {
                            selectedIndex=pagePosition;
                            await getData2();
                          setState(()  {



                          });
                            },
                      );
                    }
    ))]),
            ElevatedButton(

              onPressed: () { },
              style: ElevatedButton.styleFrom(
                primary: Colors.green[300],
                  onPrimary: Colors.black,
    ),
              child: const Text('Add to cart'),


            ),])));

  }
}
