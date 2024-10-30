import 'package:flutter/material.dart';
import 'package:my_notas/Pages/save_page.dart';
import 'package:my_notas/db/operation.dart';
import 'package:my_notas/models/materia.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();

  static const String ROUTE = "/";

}

class _ListPageState extends State<ListPage> {

  double definitiva(double nota_1, double nota_2, double nota_3){
    return (nota_1 * 0.3) + (nota_2 * 0.3) + (nota_3 * 0.4);
  }

  @override
  void didUpdateWidget(ListPage oldWidget){
    super.didUpdateWidget(oldWidget);
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SavePage(
                false
              )
            )
          );
        }
      ),
      appBar: AppBar(
        title: Text("ASIGNATURAS"),
        actions: <Widget>[
          RaisedButton(
            color: Colors.green,
            child: Icon(Icons.update, color: Colors.white,),
            onPressed: (){
              setState(() { });
            }
          ),
          RaisedButton(
            color: Colors.green,
            child: Icon(Icons.delete_forever, color: Colors.white,),
            onPressed: (){
              Operation.deleteAll();
              setState(() { });
            }
          )
        ],
      ),
      body: 
      FutureBuilder<List<Materia>>(
        future: Operation.materias(),
        builder: (BuildContext context, AsyncSnapshot<List<Materia>> snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){
                Materia item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  onDismissed: (diretion){
                    Operation.delete(item.id);
                    setState(() { });
                  },
                  child: new Card(
                    child: ListTile(
                      title: Text(item.materia),
                      subtitle: Text(item.docente),
                      trailing: Text("CREDITOS: " + item.creditos),
                      isThreeLine: true,
                      leading: CircleAvatar(
                        backgroundColor: definitiva(double.parse(item.nota1), double.parse(item.nota2), double.parse(item.nota3)) < 2.9 ? Colors.redAccent: Colors.green,
                        child: Text(
                          definitiva(double.parse(item.nota1), double.parse(item.nota2), double.parse(item.nota3)).toStringAsFixed(1),
                          style: new TextStyle(
                            color: Colors.white
                          )
                        ),
                      ), 
                      onTap: (){
                        //Navigator.pushNamed(context, SavaPage.ROUTE);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SavePage(
                              true,
                              materia: item
                            )
                          )
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }else{
            return Center(
              child: CircularProgressIndicator()
            );
          }
        }
      )
    );
  }
}