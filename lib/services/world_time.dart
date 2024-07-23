import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
 
class WorldTime {

  String location='';
  String time='';
  String flag='';
  String url='';
  bool isDayTime=true;

  WorldTime({required this.location,required this.flag,required this.url});

  Future<void> getTime() async {

    try {
    Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
    Map data = jsonDecode(response.body);
    // print(data);
    String  datetime=data['datetime'];
    String offset = data['utc_offset'];
    // print(datetime);
    // print(offset);
    String offsetSign = offset[0];
    int offsetHours = int.parse(offset.substring(1, 3));
    int offsetMinutes = int.parse(offset.substring(4, 6));

    // Parsing the datetime
    DateTime now = DateTime.parse(datetime);

    // Adjusting the datetime based on the offset
    Duration offsetDuration = Duration(
      hours: offsetSign == '+' ? offsetHours : -offsetHours,
      minutes: offsetSign == '+' ? offsetMinutes : -offsetMinutes,
    );
    now = now.add(offsetDuration);

    isDayTime= now.hour > 6 && now.hour < 20 ? true : false;
    time=DateFormat.jm().format(now);
    }
    catch(e){
      print("Error: $e");
      time='Error';
    }
  }
}

