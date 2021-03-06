import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gadjet_inventory/Form/Data.dart';
import 'package:pdf_flutter/pdf_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DetailView(),
    );
  }
}



class DetailView extends StatefulWidget {
  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {


  List<Data> dataList = [];
  List<bool> favList = [];
  bool searchState = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  String get data => null;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    DatabaseReference referenceData = FirebaseDatabase.instance.reference()
        .child("Data");
    referenceData.once().then((DataSnapshot dataSnapShot) async {
      dataList.clear();
      favList.clear();

      var keys = dataSnapShot.value.keys;
      var values = dataSnapShot.value;

      for (var key in keys) {
        Data data = new Data(
            values [key]['imgUrl'],
            values [key]['wcimgUrl'],
            values [key]['ugimgUrl'],
            values [key]['wcpdfUrl'],
            values [key]['ugpdfUrl'],
            values [key]['cattegorrytype'],
            values [key]['companyname'],
            values [key]['modelname'],
            values [key]['seriesname'],
            values [key]['serielnumber'],
            values [key]['year'],
            values [key]['warrantydate'],


            values [key]['name'],
            values [key]['mobilenumber'],
            values [key]['address'],
            values [key]['website'],

            key
          //key is the uploadid
        );
        dataList.add(data);
        // await auth.currentUser.then((value) {
        //   DatabaseReference reference = FirebaseDatabase.instance.reference()
        //       .child("Data").child(key).child("Fav")
        //       .child(value.uid)
        //       .child("state");
        //   reference.once().then((DataSnapshot snapShot) {
        //     if (snapShot.value != null) {
        //       if (snapShot.value == "true") {
        //         favList.add(true);
        //       } else {
        //         favList.add(false);
        //       }
        //     } else {
        //       favList.add(false);
        //     }
        //   });
        // });
      }


      Timer(Duration(seconds: 1), () {
        setState(() {
          //
        });
      });
    });
  }

  int selectedRadioTile;

  String get path => null;

  String get title => null;

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          "Device Details",
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
      body: dataList.length == 0
          ? Center(
        child: Text(
          "No Data Available",
          style: TextStyle(fontSize: 30),
        ),
      )
          : ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (_, index) {
          return CardUI(dataList[index]);
        },
      ),
    );
  }
}

class CardUI extends StatefulWidget {
  final Data data;
  CardUI(this.data);
  // List<Data> dataList = [];


  @override
  _CardUIState createState() => _CardUIState();
}

class _CardUIState extends State<CardUI> {
  bool _isLoading = true;
  PDFDocument doc;
  int selectedRadioTile;
  TextEditingController textEditingController = new TextEditingController();

  String get path => null;

  String get title => null;

  get index => null;

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }


  _loadFromUrl(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    doc = await PDFDocument.fromURL(
        'wcpdfUrl');
           Image.asset("assets/images/pdf.png",
        height: 1000, width: 600, );
    setState(() {
      _isLoading = false;
    });
  }


  _loadFromUrl2(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    doc = await PDFDocument.fromURL(
        'ugpdfUrl');
    Image.asset("assets/images/pdf.png",
      height: 1000, width: 600, );
    setState(() {
      _isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.all(1.5),
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Image.network(
                widget.data.imgUrl != null ? widget.data.imgUrl : '',
                width: 500,
                height: 500,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),







                      child: Text(
                        "Cattegorry Type:- "
                            "${widget.data.cattegorrytype}",
                        style: TextStyle(color: Colors.black),
                      ),

                    ),
                  ),


                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Theme(
                        data: ThemeData(
                          hintColor: Colors.blue,
                        ),

                        child: Text(
                          "Company Name:- "
                              "${widget.data.companyname}",
                          style: TextStyle(color: Colors.black),
                        ),





                        ),
                      ),
                    ),


                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Theme(
                        data: ThemeData(
                          hintColor: Colors.blue,
                        ),

                        child: Text(
                          "Model Name:- "
                              "${widget.data.modelname}",
                          style: TextStyle(color: Colors.black),
                        ),

                        ),
                      ),
                    ),




                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Theme(
                        data: ThemeData(
                          hintColor: Colors.blue,
                        ),

                        child: Text(
                          "Series Name:- "
                              "${widget.data.seriesname}",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Theme(
                        data: ThemeData(
                          hintColor: Colors.blue,
                        ),

                        child: Text(
                          "Year of MFG:- "
                              "${widget.data.year}",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),



                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Theme(
                        data: ThemeData(
                          hintColor: Colors.blue,
                        ),

                        child: Text(
                          "Seriel Number:- "
                              "${widget.data.serielnumber}",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),

                ],
              ),




              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.calendar_today),

                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Theme(
                        data: ThemeData(
                          hintColor: Colors.blue,
                        ),

                        child: Text(
                          "Year of MFG:- "
                              "${widget.data.warrantydate}",
                          style: TextStyle(color: Colors.black),

                        ),

                      ),
                    ),
                  ),




                  RaisedButton(

                    onPressed: () {
                      Fluttertoast.showToast(
                        msg: "View Service Centre Details",
                        gravity: ToastGravity.CENTER,
                        toastLength: Toast.LENGTH_LONG,
                        // timeInSecForIosWeb: 2
                      );

                      //  _startWCUpload();

                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),

                    color: Colors.blue,
                    child: Text("Service Centre Details",
                      style: TextStyle(fontSize: 18, color: Colors.white),),
                  ),





                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Theme(
                        data: ThemeData(
                          hintColor: Colors.blue,
                        ),

                        child: Text(
                          "Name:- "
                              "${widget.data.name}",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),

                ],
              ),




              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Theme(
                        data: ThemeData(
                          hintColor: Colors.blue,
                        ),

                        child: Text(
                          "Mobile Number:- "
                              "${widget.data.mobilenumber}",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),




                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Theme(
                        data: ThemeData(
                          hintColor: Colors.blue,
                        ),

                        child: Text(
                          "Address:- "
                              "${widget.data.address}",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),


                ],
              ),



              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  IconButton(
                    icon: Icon(Icons.open_in_browser),
                      onPressed:  () async {
                      if(textEditingController.text.toString() == null || textEditingController.text.toString() == ""){
                        print("null data");
                      }else{
                        print(textEditingController.text.toString());
                        if (await canLaunch("https://" + textEditingController.text.toString())) {
                          await launch("https://" + textEditingController.text.toString());
                        } else {
                          throw 'Could not launch ${textEditingController.text.toString()}';
                        }
                      }
                    },
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Theme(
                        data: ThemeData(
                          hintColor: Colors.blue,
                        ),
                        child:Text( "Website:- "
                            "${widget.data.website}",
                          style: TextStyle(color: Colors.black),

                           ),

                        ),


                        ),

                        ),


                 SizedBox(width: 5,),

                ],
              ),








              RaisedButton(


                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),

                color: Colors.blue,
                child: Text("Warranty Card",
                  style: TextStyle(fontSize: 18, color: Colors.white),),
              ),
              RadioListTile(
                value: 1,
                groupValue: selectedRadioTile,
                title: Text("PDF"),
                //subtitle: Text("Upload PDF File"),
                /*  onChanged: (val) {
                        filePicker(context);
                      },*/
                activeColor: Colors.red,


              ),

              Padding(padding: EdgeInsets.only(top: 15)),

              //  _buildPDF1Field(context),
              _loadFromUrl(context),


              /*PDF.network(
                widget.data.wcpdfUrl != null
                    ?  widget.data.wcpdfUrl
                    : '',

                width: 600,
                height: 1000,     placeHolder: Image.asset("assets/images/pdf.png",
                  height: 600, width: 500),
              ),*/
              SizedBox(height: 24),


              RadioListTile(
                value: 2,
                groupValue: selectedRadioTile,
                title: Text("Image"),
                //subtitle: Text("Upload W Card Image"),
                /* onChanged: (val) {
                        openWCImagePickerModal(context);
                        //_startWCUpload();
                      },*/
                activeColor: Colors.blue,


              ),

              Padding(padding: EdgeInsets.only(top: 15)),

              Image.network(
                widget.data.wcimgUrl != null
                    ?  widget.data.wcimgUrl
                    : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                width: 500,
                height: 500,

              ),



              SizedBox(height: 24),
              SizedBox(height: 10,),

              Padding(padding: EdgeInsets.only(top: 15)),
              /*Container(
                    child: imageFile2==null?
                    FlatButton(
                        onPressed: (){
                          openWCImagePickerModal(context);
                        },
                        child: Icon(Icons.add_a_photo,size: 80,color: Colors.blueGrey,)
                    ):
                    Image.file(imageFile2,width: 200,height: 100,),
                  ),*/

              SizedBox(height: 10,),



              /* _uploaded2 == false?Container():*/
              /*    RaisedButton(child:Text("Download Image"),
                    /*  onPressed:(){ downloadImage2();},*/),*/

              /*     _downloadUrl2==null?Container():Image.network(_downloadUrl2),*/

              RaisedButton(

                onPressed: () {
                  Fluttertoast.showToast(
                    msg: "Upload User Guide",
                    gravity: ToastGravity.CENTER,
                    toastLength: Toast.LENGTH_LONG,
                    // timeInSecForIosWeb: 2
                  );

                  // startUpload();

                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                // color: Color(0xffff2fc3),
                color: Colors.blue,
                child: Text("User Guide",
                  style: TextStyle(fontSize: 18, color: Colors.white),),
              ),
              RadioListTile(
                value: 1,
                groupValue: selectedRadioTile,
                title: Text("PDF"),
                //subtitle: Text("Upload PDF File"),
                /* onChanged: (val) {
                      filePicker2(context);
                    },*/
                activeColor: Colors.red,


              ),
              Padding(padding: EdgeInsets.only(top: 15)),

              _loadFromUrl2(context),

             /* PDF.network(
                widget.data.ugpdfUrl != null
                    ? widget.data.ugpdfUrl
                    : '',
                width: 600,
                height: 1000,     placeHolder: Image.asset("assets/images/pdf.png",
                  height: 600, width: 500),
              ),*/


              SizedBox(height: 24),













              RadioListTile(
                value: 2,
                groupValue: selectedRadioTile,
                title: Text("Image"),
                //subtitle: Text("Upload W Card Image"),
                /*  onChanged: (val) {
                        openUGImagePickerModal(context);
                        //_startUGUpload();
                      },*/
                activeColor: Colors.blue,


              ),

              Padding(padding: EdgeInsets.only(top: 15)),



              Image.network(
                widget.data.ugimgUrl != null
                    ?  widget.data.ugimgUrl
                    : '',
                width: 500,
                height: 500,

              ),



              SizedBox(height: 16),

              SizedBox(height: 10,),






              /* Text(
                  "Ingredients",
                  style: TextStyle(fontSize: 18, decoration: TextDecoration.underline),
                ),*/





              SizedBox(height: 16),




            ],
          ),
        ),

      ),
    );

  }


}



