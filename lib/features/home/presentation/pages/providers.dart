import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ieee_mvp/features/home/domain/entities/provider.dart';
import 'package:ieee_mvp/features/home/presentation/pages/secondary_provider.dart';

class Providers extends StatefulWidget {
  @override
  _ProvidersState createState() => _ProvidersState();
}

class _ProvidersState extends State<Providers> {
  List<Provider> providers = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 20; i++) {
      providers.add(Provider(
          name: 'provider name #$i',
          location: 'provider location #$i',
          mobile: '059-XXX-XXXX #$i'));
    }
  }

  List<Widget> actions = [
    IconSlideAction(
      caption: 'Order',
      icon: Icons.add,
      onTap: (){},
    ),
    IconSlideAction(
      caption: 'Map',
      icon: Icons.map,
      onTap: (){},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: providers.length,
      itemBuilder: (context, position) {
        return Slidable(
          actionPane: SlidableScrollActionPane(),
          actionExtentRatio: 0.25,
          child: Column(
            children: <Widget>[
              ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => SecondaryProvider(provider: providers[position],)));
                },
                title: Text(providers[position].name),
                subtitle: Text(providers[position].location),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(providers[position].mobile),
                    Text(''),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                height: 1,
                color: Colors.grey[100],
              )
            ],
          ),
          actions: actions,
          secondaryActions: actions,
        );
      },
    );
  }
}
