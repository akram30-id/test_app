import 'package:flutter/material.dart';
import 'package:test_app/local_storage/MahasiswaModel.dart';
import 'package:test_app/local_storage/MySqflite.dart';

class SqfliteActivity extends StatefulWidget {
  @override
  _SqfliteActivityState createState() => _SqfliteActivityState();
}

class _SqfliteActivityState extends State<SqfliteActivity> {
  final keyFormMahasiswa = GlobalKey<FormState>();
  final keyUpdateMahasiswa = GlobalKey<FormState>();

  TextEditingController controllerNim = TextEditingController();
  TextEditingController controllerNama = TextEditingController();
  TextEditingController controllerDepartment = TextEditingController();
  TextEditingController controllerSks = TextEditingController();

  String nim = "";
  String name = "";
  String departement = "";
  int sks = 0;

  List<MahasiswaModel> mahasiswa = [];

  String _onValidateText(String value) {
    if (value.isEmpty) return 'Tidak boleh kosong';
    return null;
  }

  _onSaveMahasiswa() async {
    FocusScope.of(context).requestFocus(new FocusNode());

    if (keyFormMahasiswa.currentState.validate()) {
      keyFormMahasiswa.currentState.save();
      controllerNim.text = "";
      controllerNama.text = "";
      controllerDepartment.text = "";
      controllerSks.text = "";

      await MySqflite.instance.insertMahasiswa(MahasiswaModel(
        nim: nim,
        name: name,
        departement: departement,
        sks: sks,
      ));
      mahasiswa = await MySqflite.instance.getMahasiswa();
      setState(() {});
    }
  }

  _reset() async {
    mahasiswa = await MySqflite.instance.clearAllData();
    mahasiswa = await MySqflite.instance.getMahasiswa();
    setState(() {});
  }

  _delete(String nim) async {
    await MySqflite.instance.deleteMahasiswa(nim);
    mahasiswa = await MySqflite.instance.getMahasiswa();
    setState(() {});
  }

  dialogReset() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(20),
            children: [
              Text(
                "Are you sure want to reset ?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    child: Text("No"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  InkWell(
                    child: Text("Yes"),
                    onTap: () {
                      _reset();
                      Navigator.pop(context);
                    },
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  dialogDelete(nim) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(20),
            children: [
              Text(
                "Are you sure want to delete this mahasiswa ?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    child: Text("No"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  InkWell(
                    child: Text("Yes"),
                    onTap: () {
                      _delete(nim);
                      Navigator.pop(context);
                    },
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  // dialogUpdate(nim) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         child: ListView(
  //           shrinkWrap: true,
  //           padding: EdgeInsets.all(20),
  //           children: [
  //             Form(
  //               key: keyUpdateMahasiswa,
  //               child: Container(
  //                 child: Column(
  //                   children: [
  //                     TextFormField(
  //                       controller: txtDep,
  //                       decoration: InputDecoration(hintText: "Departement"),
  //                       validator: (value) => _onValidateText(value),
  //                       onSaved: (value) => departement = value,
  //                     ),
  //                     SizedBox(height: 16),
  //                     // ignore: deprecated_member_use
  //                     RaisedButton(
  //                       onPressed: () {
  //                         _onUpdate(nim, name, departement, sks);
  //                         Navigator.pop(context);
  //                       },
  //                       child: Text('Update'),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  setupUpdate(String nim, nama, dep, sks) {
    controllerNim.text = "$nim";
    controllerNama.text = "$nama";
    controllerDepartment.text = "$dep";
    controllerSks.text = "$sks";
  }

  _onUpdate(String nim, nama, dep, sks) async {
    FocusScope.of(context).requestFocus(new FocusNode());

    if (keyFormMahasiswa.currentState.validate()) {
      keyUpdateMahasiswa.currentState.save();
      controllerNim.text = "";
      controllerNama.text = "";
      controllerDepartment.text = "";
      controllerSks.text = "";

      await MySqflite.instance.updateMahasiswaDepartement(MahasiswaModel(
        nim: nim,
        departement: departement,
      ));
      mahasiswa = await MySqflite.instance.getMahasiswa();
      setState(() {});
    }
  }

  // Widget _btnSubmit(method, String txt) {
  //   return Container(
  //     margin: EdgeInsets.only(left: 24, right: 24),
  //     child: RaisedButton(
  //       onPressed: () {
  //         method;
  //       },
  //       child: Text(txt),
  //     ),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      mahasiswa = await MySqflite.instance.getMahasiswa();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(top: 36, left: 24, bottom: 4),
            child: Text(
              "Input Mahasiswa",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          //form widget
          Form(
            key: keyFormMahasiswa,
            child: Container(
              margin: EdgeInsets.only(left: 24, right: 24),
              child: Column(
                children: [
                  TextFormField(
                    controller: controllerNim,
                    decoration: InputDecoration(hintText: "NIM"),
                    validator: (value) => _onValidateText(value),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => nim = value,
                  ),
                  TextFormField(
                    controller: controllerNama,
                    decoration: InputDecoration(hintText: "Nama"),
                    validator: (value) => _onValidateText(value),
                    onSaved: (value) => name = value,
                  ),
                  TextFormField(
                    controller: controllerDepartment,
                    decoration: InputDecoration(hintText: "Jurusan"),
                    validator: (value) => _onValidateText(value),
                    onSaved: (value) => departement = value,
                  ),
                  TextFormField(
                    controller: controllerSks,
                    decoration: InputDecoration(hintText: "SKS"),
                    validator: (value) => _onValidateText(value),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => sks = int.parse(value),
                  ),
                ],
              ),
            ),
          ),
          //button widget
          Container(
            margin: EdgeInsets.only(left: 24, right: 24),
            child: RaisedButton(
              onPressed: () {
                _onSaveMahasiswa();
              },
              child: Text('Simpan'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 24, left: 24, bottom: 4),
            child: Text(
              "Data Mahasiswa",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: mahasiswa.length,
              padding: EdgeInsets.fromLTRB(24, 0, 24, 8),
              itemBuilder: (BuildContext context, int index) {
                var value = mahasiswa[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Nim: ${value.nim}"),
                      Text("Nama: ${value.name}"),
                      Text("Departemen: ${value.departement}"),
                      Text("Sks: ${value.sks}"),
                      Row(
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                dialogDelete(value.nim);
                              }),
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              // dialogUpdate(value.nim);
                              setState(() {
                                setupUpdate(value.nim, value.name,
                                    value.departement, value.sks);
                                // button(
                                //   _onUpdate(value.nim, value.name,
                                //       value.departement, value.sks),
                                //   'Update',
                                // );
                              });
                              print(value.departement);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          InkWell(
            onTap: () {
              dialogReset();
            },
            child: Container(
              width: 75,
              height: 50,
              color: Colors.red,
              child: Center(
                child: Text(
                  'Reset',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
