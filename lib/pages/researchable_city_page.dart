import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ResearchCityPage extends StatefulWidget {
  @override
  _ResearchCityPageState createState() => _ResearchCityPageState();
}

class _ResearchCityPageState extends State<ResearchCityPage> {
  TextEditingController cityNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cityNameController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
        child: TextFormField(
          controller: cityNameController,
          style: TextStyle(),
          decoration: InputDecoration(
            hintText: 'Enter city name',
            labelText: 'City Name',
            prefixIcon: Icon(
              Icons.location_city,
            ),
            suffixIcon: IconButton(
              icon: Icon(FontAwesomeIcons.search),
              onPressed: (){
                Navigator.pop(context,cityNameController.text);
              },
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Colors.white54,
                  width: 2),
              borderRadius: BorderRadius.circular(
                50,
              ),
            ),
          ),
        ),
      ),
    );
  }
}