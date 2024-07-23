import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data ={};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data: ModalRoute.of(context)!.settings.arguments as Map;

    String bgImage = data['isDayTime']?'day.jpg':'night.jpg';
    Color bgColor = data['isDayTime']?Colors.lightBlue:Colors.indigo;

    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/$bgImage"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0,120.0,0,0),
          child: SafeArea(
            child: Column(
              children: <Widget> [
                TextButton.icon(
                  onPressed: () async{
                    dynamic result=  await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data={
                        'time':result['time'],
                        'location':result['location'],
                        'isDayTime':result['isDayTime'],
                        'flag':result['flag'],
                      };
                    });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    
                    ),
                  label: Text('Edit location',
                  style: TextStyle(
                    
                  ),
                  ),
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget> [
                    Text(data['location'],
                    style: TextStyle(
                      fontSize: 20.0,
                      letterSpacing: 2.0,
                      color: Colors.white,
                    ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                 CircleAvatar(
                backgroundImage: AssetImage(("assets/${data['flag']}")),
                radius: 40.0,
              ),
                SizedBox(height: 20.0,),
                Text(data['time'],
                style: TextStyle(
                  fontSize: 66.0,
                  color: Colors.white,
                ),
                ),
        
          
              ],
              )
            ),
        ),
      ),
    );
  }
}