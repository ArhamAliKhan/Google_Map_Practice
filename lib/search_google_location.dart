import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class SearchGoogleLocation extends StatefulWidget {
  const SearchGoogleLocation({super.key});

  @override
  State<SearchGoogleLocation> createState() => _SearchGoogleLocationState();
}

class _SearchGoogleLocationState extends State<SearchGoogleLocation> {
  TextEditingController _controller = TextEditingController();
  List<dynamic> _placeList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String PLACES_API_KEY = "AIzaSyA9ky7bMd3tqhDxChF8CJbWbl1I86_cu8Y";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$PLACES_API_KEY&sessiontoken=$_sessionToken';
    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print(response.body.toString());
    if (response.statusCode == 200) {
      setState(() {
        _placeList = jsonDecode(response.body.toString())['prediction'];
      });
    } else {
      throw Exception("Failed to load data");
    }
  }

  var uuid = Uuid();
  String _sessionToken = '122344';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SearchGoogleLocation",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search places by country',
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: _placeList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_placeList[index]['description']),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
