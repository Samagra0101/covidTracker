import 'package:covid_app/services/stats_services.dart';
import 'package:covid_app/view/detail.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                onChanged: (value){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search Country',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0)
                  )
                ),
              ),
            ),
            Expanded(child: FutureBuilder(
              future: statsServices.countryListApi(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                if(!snapshot.hasData){
                  return ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Shimmer(
                          gradient: LinearGradient(colors: Colors.primaries),
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(height: 10,width: 80,color: Colors.grey,),
                                subtitle: Container(height: 10,width: 80,color: Colors.grey,),
                                leading: Container(height: 50,width: 50,color: Colors.grey,),
                              )
                            ],
                          ),


                        );
                      }
                  );
                }
                else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                      String name = snapshot.data![index]['country'];
                      if(searchController.text.isEmpty){
                        return Column(
                        children: [
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Detail(
                              name: snapshot.data![index]['country'],
                              image: snapshot.data![index]['countryInfo']['flag'],
                              totalCases: snapshot.data![index]['cases'],
                              totalDeaths: snapshot.data![index]['deaths'],
                              totalRecovered: snapshot.data![index]['recovered'],
                              test: snapshot.data![index]['tests'],
                              critical: snapshot.data![index]['critical'],


                            )));
                          },
                          child: ListTile(
                          title: Text(snapshot.data![index]['country']),
                          subtitle: Text(snapshot.data![index]['cases'].toString()),
                          leading: Image(
                          height: 50,
                          width: 50,
                          image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),),
                          ),
                        )
                        ],
                        );
                        }
                      else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) =>
                                Detail(
                                  name: snapshot.data![index]['country'],
                                  image: snapshot
                                      .data![index]['countryInfo']['flag'],
                                  totalCases: snapshot.data![index]['cases'],
                                  totalDeaths: snapshot.data![index]['deaths'],
                                  totalRecovered: snapshot
                                      .data![index]['recovered'],
                                  test: snapshot.data![index]['tests'],
                                  critical: snapshot.data![index]['critical'],


                                )));
                          },
                          child: Column(
                          children: [
                          ListTile(
                          title: Text(snapshot.data![index]['country']),
                          subtitle: Text(snapshot.data![index]['cases'].toString()),
                          leading: Image(
                          height: 50,
                          width: 50,
                          image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),),
                          )
                          ],
                          ),
                        );
                        }
                      else{
                        return Container();
                      }

                  }
                  );
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
