import 'package:flutter/material.dart';
import 'dart:convert';
import 'clubs.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/services.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Club club = new Club();
  TextEditingController _textEditingController = new TextEditingController();

  Future<String> loadJson() async {
    return rootBundle.loadString('assets/clubs.json');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textEditingController.dispose();
  }

  Widget _buildTextField(List clubs) {
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        autofocus: false,
        controller: _textEditingController,
        style: TextStyle(
          color: Colors.black54,
          fontSize: 18.0,
        ),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "Search football clubs",
          labelStyle: TextStyle(color: Colors.black38),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
        ),
      ),
      suggestionsCallback: (String query) {
        return getClubSuggestions(query, clubs);
      },
      onSuggestionSelected: (Club club) {
        setState(() {
          this.club = club;
        });
        _textEditingController.text = club.name;
      },
      noItemsFoundBuilder: (BuildContext context) {
        return ListTile(
          title: Text('Club not found..'),
        );
      },
      itemBuilder: (BuildContext context, Club club) {
        return ListTile(
          title: Text(club.name),
          subtitle: Text(
            'ID: ${club.id}, Code: ${club.code}',
            style: TextStyle(
              fontSize: 12.0,
              fontStyle: FontStyle.italic,
            ),
          ),
        );
      },
    );
  }

  Widget _buildOutput() {
    return Text("""
        Result for club selected:
        ID: ${club.id ?? '-'},
        Name: ${club.name ?? '-'},
        Code: ${club.code ?? '-'}
      """);
  }

  Widget _buildContainer(List<Club> clubs) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: [
            _buildTextField(clubs),
            SizedBox(height: 16.0),
            _buildOutput(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Autocomplete Search'),
        centerTitle: true,
      ),
      body: FutureBuilder<String>(
        future: loadJson(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final dataMaster = DataMaster.fromJson(json.decode(snapshot.data));
            return _buildContainer(dataMaster.clubs);
          } else {
            return Center(
              child: Text('Error load data'),
            );
          }
        },
      ),
    );
  }
}
