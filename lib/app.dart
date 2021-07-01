import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final Color orange = Color(0xffF57476);
final Color purple = Color(0xff5A5FE3);

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List task = [
    [
      'meeting with friend',
      '2:56',
      false,
    ],
    [
      'lunch at 2',
      '7:20',
      false,
    ],
    ['go for shopping', '16:20', false],
    ['assignment submission', '9:12', false],

  ];
  String timestamp = '';
  timeNow(){
    final DateTime now = DateTime.now();
    String time = DateFormat('hh:mm').format(now);
    setState((){
      timestamp = time;
    });
    print(timestamp);
  }
  String newTask = '';
  Icon check = Icon(Icons.check_box_outline_blank);
  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    String day = DateFormat('EEEE').format(now);
    String date = DateFormat('d/MMMM/y').format(now);
    String time = DateFormat('hh:mm').format(now);
    int items = task.length;
    
    return Scaffold(
        body: Stack(
      children: [
        Column(
            children: [
                  Material(
                    shadowColor: Colors.black,
                    elevation: 10.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: orange, width: 5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(4, 4),
                        blurRadius: 0,
                        spreadRadius: 0
                      )
                    ]
              
                  ),
                    padding:
                        EdgeInsets.only(top: 50, bottom: 30, left: 10, right: 20),
                    child:Column(
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
                                          color: purple,
                                          fontSize: 35,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    Text(
                                      '$items items',
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
                      ),
                    ),
              ),
              Expanded(
                child: 
                 Container(
                   height: 900,
                  color: purple,
                   child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: 
                Column(
                    children: [
                      Container(
                      padding: EdgeInsets.only(top: 50, bottom: 50, left: 10, right: 10),
                        width: MediaQuery.of(context).size.width,
                        child: taskItems()),
                    ],
                ),),
                 )
 
                // ListView.builder(
                //   itemCount: 5,
                //   itemBuilder: (BuildContext context, index){
                //   return ;
                // })
              )
            ],
          ),
        // tasks list
        // add item floating button
        Positioned(
          top: 115,
          right: 30,
          child: FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: orange,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Add new Task'),
                      titleTextStyle: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                      contentPadding: EdgeInsets.all(15),
                      content: TextField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.sentences,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            height: 2,
                            letterSpacing: 0.1),
                        maxLines: null,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 3, horizontal: 5),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: purple)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: purple,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            // border: OutlineInputBorder(),
                            hintText: 'My New task',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            )),
                        onChanged: (value) {
                          setState(() {
                            newTask = value;
                          });
                        },
                      ),
                      actions: [
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(purple),
                            ),
                            onPressed: () {
                              setState(() {
                                task.add([newTask, time, false]);
                              });
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Add Task',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(purple),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ))
                      ],
                    );
                  });
            },
          ),
        ),
      ],
    ));
  }
  
  taskItems() {
    return Container(
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: task.length,
          itemBuilder: (BuildContext context, index) {
            return Container(
                child: Container(
                    child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  task[index][2]
                                      ? task[index][2] = false
                                      : task[index][2] = true;
                                });
                              },
                              child: task[index][2]
                                  ? Icon(
                                      Icons.check_box,
                                      color: orange,
                                    )
                                  : Icon(
                                      Icons.check_box_outline_blank,
                                      color: Colors.grey,
                                    )),
                        ),
                        Text(
                          '${task[index][0]}',
                          style: TextStyle(
                            color: task[index][2] ? Colors.grey : Colors.black,
                            fontSize: 16,
                            decoration: task[index][2]
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        )
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
                                IconButton(
                                    padding: EdgeInsets.all(0),
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('Edit task'),
                                              titleTextStyle: TextStyle(
                                                  color: Colors.deepPurple,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0),
                                              contentPadding:
                                                  EdgeInsets.all(15),
                                              content: TextField(
                                                keyboardType:
                                                    TextInputType.text,
                                                textInputAction:
                                                    TextInputAction.done,
                                                autocorrect: false,
                                                textCapitalization:
                                                    TextCapitalization
                                                        .sentences,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 15,
                                                    height: 2,
                                                    letterSpacing: 0.1),
                                                maxLines: null,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 3,
                                                          horizontal: 5),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          borderSide:
                                                              BorderSide(
                                                                  color:
                                                                      purple)),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: purple,
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                ),
                                                controller:
                                                    TextEditingController(
                                                        text:
                                                            '${task[index][0]}'),
                                                onChanged: (val) {
                                                  setState(() {
                                                    newTask = val;
                                                  });
                                                },
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(purple),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        task[index].replaceRange(
                                                            0,
                                                            1,
                                                            [newTask]);
                                                            task[index].replaceRange(
                                                            1,
                                                            2,
                                                            [timestamp]);
                                                            task[index].replaceRange(
                                                            2,
                                                            3,
                                                            [false]);
                                                        Navigator.of(context)
                                                            .pop();
                                                      });
                                                    },
                                                    child: Text(
                                                      'Edit Task',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )),
                                                ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(purple),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        Navigator.of(context)
                                                            .pop();
                                                      });
                                                    },
                                                    child: Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )),
                                              ],
                                            );
                                          });
                                    }),
                                IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        task.removeAt(index);
                                      });
                                    })
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Text(
                                '${task[index][1]}',
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
            )));
          }),
    );
  }
}
