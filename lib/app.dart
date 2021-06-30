import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List tasks = ['have coffee', 'grab for lunch', 'tea time'];
  String newTask = '';
  var replce = '';
  Icon check = Icon(Icons.check_box_outline_blank);
  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    String day = DateFormat('EEEE').format(now);
    String date = DateFormat('d/MMMM/y').format(now);
    return Scaffold(
        body: Stack(
        children: [
        Column(
          children: [
            Container(
                color: Colors.white,
                padding:
                    EdgeInsets.only(top: 50, bottom: 30, left: 10, right: 20),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '$day',
                                style: TextStyle(
                                    color: Color(0xff5C5FE4),
                                    fontSize: 35,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                '12 items',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '$date',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          
                        ],
                      ),
                    )
                  ],
                )),
          ],
        ),
        Positioned(
          top:150,
          child: Container(
            padding: EdgeInsets.only(top: 50),
            color: Colors.deepPurple,
            width: MediaQuery.of(context).size.width,
            height: 900,
            child: taskItems())),
        Positioned(
          top: 115,
          right: 30,
          child: FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Color(0xffFA7274),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Add new Task'),
                      content: TextField(
                        onChanged: (value) {
                          setState(() {
                            newTask = value;
                          });
                        },
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                              tasks.add(newTask);
                         
                                                            });
                              Navigator.of(context).pop();
                            },
                            child: Text('Add Task')),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'))
                      ],
                    );
                  });
            },
          ),
        ),
      ],
    ));
  }
taskItems(){
      return Container(
      child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, index){
                return Container(
                 child: Container(
        height: 100,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onTap: () {
                            this.setState(() {
                              check = Icon(Icons.check_box);
                            });
                          },
                          child: check),
                    ),
                    Text('${tasks[index]}')
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(icon: Icon(
                                Icons.edit,
                                color: Colors.green,
                              ), 
                              onPressed: (){
                                  showDialog(context: context, 
                                  builder: (context){
                                    return AlertDialog(
                                      title: Text('Edit task'),
                                      content: TextField(
                                        controller: TextEditingController(text: '${tasks[index]}'),
                                        onChanged: (val){
                                          setState(() {
                                            newTask = val;
                                          });
                                        }, 
                                      ),
                                      actions: [
                                        ElevatedButton(onPressed: (){
                                          setState(() {
                                            tasks.replaceRange(index, index+1, [newTask]); 
                                            Navigator.maybeOf(context).pop();                               });
                                        }, 
                                        child: Text('Edit Task')),
                                        ElevatedButton(onPressed: (){
                                          setState(() { 
                                            Navigator.maybeOf(context).pop();                               });
                                        }, 
                                        child: Text('Cancel')),
                                      ],
                                    );
                                  });
}),
                            IconButton(
                              icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ), 
                            onPressed: (){
                              setState(() {
                                  tasks.removeAt(index);
                                                            });
                            })
                            
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Text(
                            '2.56 PM',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ))
                  );}),
    );
}
}