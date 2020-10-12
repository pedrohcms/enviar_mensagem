import 'dart:io';
import 'package:enviar_mensagem/src/pages/Home/HomeBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _messageController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Enviar Mensagens"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.exit_to_app),
        onPressed: () {
          exit(0);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      body: Form(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 11.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Informe os dados",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Digite o nome",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: "Digite a mensagem",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                height: 40.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: BorderSide(color: Colors.blue),
                  ),
                  onPressed: () async {
                    _scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.blue,
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Processando",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );

                    Map<String, dynamic> response = await HomeBloc.sendMessage(
                      _nameController.text,
                      _messageController.text,
                    );

                    // REMOVO A SNACKBAR QUANDO TERMINAR DE CARREGAR
                    _scaffoldKey.currentState.removeCurrentSnackBar();

                    showDialog(
                      context: context,
                      builder: (_) => CupertinoAlertDialog(
                        title: new Text(
                          response["sucesso"] == true ? "Sucesso" : "Erro",
                        ),
                        content: new Text(response["mensagem"]),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );

                    _nameController.text = "";
                    _messageController.text = "";
                  },
                  child: Text(
                    "Enviar",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
