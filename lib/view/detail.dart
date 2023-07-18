import 'package:covid_app/view/world_stats.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  String name='';
  String image='';
  int totalCases=0,totalDeaths=0,totalRecovered=0,critical=0,test=0;
  Detail({
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.critical,
    required this.test,


}) ;


  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.06,),
                      ReuseRow(title: 'Cases', value: widget.totalCases.toString()),
                      ReuseRow(title: 'Recovered', value: widget.totalRecovered.toString()),
                      ReuseRow(title: 'Deaths', value: widget.totalDeaths.toString()),
                      ReuseRow(title: 'Tests', value: widget.test.toString()),
                      ReuseRow(title: 'Critical', value: widget.critical.toString()),

                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
