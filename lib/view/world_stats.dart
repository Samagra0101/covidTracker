import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:covid_app/services/stats_services.dart';

import '../models/WorldStatsModel.dart';
import 'countries_list.dart';


class WorldStats extends StatefulWidget {
  const WorldStats({Key? key}) : super(key: key);

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(duration: Duration(seconds: 4), vsync: this)..repeat;

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
}
final colorlist = <Color>[
  const Color(0xff4285F4),
  const Color(0xff1aa320),
  const Color(0xffde5246),

  ];

  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return  Scaffold(
      body: SafeArea(child:
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*.01,),
            FutureBuilder(
              future: statsServices.getApi(),
                builder: (context, AsyncSnapshot<WorldStatsModel> snapshot){
              if(!snapshot.hasData){
                return Expanded(
                  flex : 1,
                  child: SpinKitFadingCircle(
                    color: Colors.blueAccent,
                    size: 50.0,
                    controller: _controller,
                  ),
                );
              }
              else{
                return Column(
                  children: [
                    PieChart(
                      dataMap: {
                        "Total": double.parse(snapshot.data!.cases!.toString()),
                        "Recovered" : double.parse(snapshot.data!.recovered!.toString()),
                        "Deaths" : double.parse(snapshot.data!.deaths!.toString()),
                      },
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValuesInPercentage: true
                      ),
                      animationDuration: Duration(milliseconds: 1200),
                      chartType: ChartType.disc,
                      colorList: colorlist,
                      chartRadius: MediaQuery.of(context).size.width/3.2,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.06),
                      child: Card(
                        child: Column(
                          children: [
                            ReuseRow(title: 'Total', value: snapshot.data!.cases.toString()),
                            ReuseRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                            ReuseRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                            ReuseRow(title: 'Active', value: snapshot.data!.active.toString()),
                            ReuseRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                            ReuseRow(title: 'Today deaths', value: snapshot.data!.todayDeaths.toString()),
                            ReuseRow(title: 'Today cases', value: snapshot.data!.todayCases.toString()),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xff1aa260),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text('Track Country'),
                        ),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesListScreen()));
                      },
                    )
                  ],
                );
              }
            }),

          ],
        ),
      )),
    );
  }
}

class ReuseRow extends StatelessWidget {
  String title,value;
   ReuseRow({Key? key, required this.title, required this.value}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5,),
          Divider()
        ],
      ),
    );
  }
}
