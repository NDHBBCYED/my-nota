import 'package:flutter/material.dart';

import 'package:my_notas/db/operation.dart';
import 'package:my_notas/models/materia.dart';

// ignore: must_be_immutable
class SavePage extends StatefulWidget {

  static const String ROUTE = "/save";

  bool flag;
  Materia materia;

  SavePage(
    this.flag,
    {this.materia}
  )
  : assert(flag == true || materia == null);

  @override
  _SavePageState createState() => _SavePageState();
}

class _SavePageState extends State<SavePage>
{

  final _formKey = GlobalKey<FormState>();

  final materiaController = TextEditingController();
  final docenteController = TextEditingController();
  final creditosController = TextEditingController();
  final nota1Controller = TextEditingController();
  final nota2Controller = TextEditingController();
  final nota3Controller = TextEditingController();

  @override
  void initState(){
    super.initState();
    if (widget.flag == true) {
      materiaController.text = widget.materia.materia;
      docenteController.text = widget.materia.docente;
      creditosController.text = widget.materia.creditos;
      nota1Controller.text = widget.materia.nota1;
      nota2Controller.text = widget.materia.nota2;
      nota3Controller.text = widget.materia.nota3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.flag?"EDITAR ASIGNATURA": "GUARDAR")
      ),
      body: Container(
        padding: EdgeInsets.all(25),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text(
              "DATOS DE LA ASIGNATURA", 
              style: new TextStyle(
                fontSize: 20.0
              ),
            ),
            TextFormField(
              textCapitalization: TextCapitalization.characters,
              maxLength: 35,
              controller: materiaController,
              validator: (value){
                if (value.isEmpty) {
                  return "ERROR";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "ASIGNATURA",
                //border: OutlineInputBorder() borderRadius: BorderRadius.all(Radius.circular(10))
              )
            ),
            TextFormField(
              textCapitalization: TextCapitalization.characters,
              maxLength: 35,
              controller: docenteController,
              validator: (value){
                if (value.isEmpty) {
                  return "ERROR";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "DOCENTE",
                //border: OutlineInputBorder() borderRadius: BorderRadius.all(Radius.circular(10))
              )
            ),
            TextFormField(
              maxLength: 1,
              controller: creditosController,
              keyboardType: TextInputType.number,
              validator: (value){
                final val = int.tryParse(value);
                if (val > 4 || value.isEmpty) {
                  return "ERROR";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "CREDITOS",
                //border: OutlineInputBorder() borderRadius: BorderRadius.all(Radius.circular(10))
              )
            ),
            Text(
              "NOTAS", 
              style: new TextStyle(
                fontSize: 20.0
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    maxLength: 3,
                    controller: nota1Controller,
                    keyboardType: TextInputType.number,
                    validator: (value){
                      final val = double.tryParse(value);
                      if (val > 5 || value.isEmpty) {
                        return "ERROR";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "30%",
                      //border: OutlineInputBorder() borderRadius: BorderRadius.all(Radius.circular(10))
                    )
                  ),
                ),
                Expanded(child: SizedBox( height: 2)),
                Expanded(
                  child: TextFormField(
                    maxLength: 3,
                    controller: nota2Controller,
                    keyboardType: TextInputType.number,
                    validator: (value){
                      final val = double.tryParse(value);
                      if (val > 5 || value.isEmpty) {
                        return "ERROR";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "30%",
                      //border: OutlineInputBorder() borderRadius: BorderRadius.all(Radius.circular(10))
                    )
                  ),
                ),
                Expanded(child: SizedBox( height: 2)),
                Expanded(
                  child: TextFormField(
                    maxLength: 3,
                    controller: nota3Controller,
                    keyboardType: TextInputType.number,
                    validator: (value){
                      final val = double.tryParse(value);
                      if (val > 5 || value.isEmpty) {
                        return "ERROR";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "40%",
                      //border: OutlineInputBorder() borderRadius: BorderRadius.all(Radius.circular(10))
                    )
                  ),
                )
              ],
            ),
            RaisedButton(
              color: Colors.green,
              child: Text(
                "GUARDAR", 
                style: new TextStyle(
                  color: Colors.white
                ),
              ),
              onPressed: (){
                if (widget.flag) {
                  if (_formKey.currentState.validate()) {
                    Operation.update(
                      Materia(
                        id: widget.materia.id,materia: materiaController.text,
                        docente: docenteController.text,
                        creditos: creditosController.text,
                        nota1: nota1Controller.text,
                        nota2: nota2Controller.text,
                        nota3: nota3Controller.text
                      )
                    );
                  }  
                } else {
                  if (_formKey.currentState.validate()) {
                    Operation.insert(
                      Materia(
                        materia: materiaController.text,
                        docente: docenteController.text,
                        creditos: creditosController.text,
                        nota1: nota1Controller.text,
                        nota2: nota2Controller.text,
                        nota3: nota3Controller.text
                      )
                    );
                  }
                }
                // ignore: unnecessary_statements
                _formKey.currentState.validate() ? Navigator.pop(context) : null;
              }
            )
          ]
        ),
      )
      ),
    );
  }
}