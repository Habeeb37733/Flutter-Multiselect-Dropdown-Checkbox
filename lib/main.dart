import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      home: dropdwn(),
    )
  );
}
class multiselct extends StatefulWidget {
  final List<String> items;
  const multiselct({Key? key,required this.items}) : super(key: key);

  @override
  State<multiselct> createState() => _multiselctState();
}

class _multiselctState extends State<multiselct> {
  final List<String> _selectitems=[];

  void _itemchange(String itemValue, bool isSelected){
    setState(() {
      if(isSelected) {
        _selectitems.add(itemValue);
      }else{
        _selectitems.remove(itemValue);
      }
    });
  }

  void _cancel(){
    Navigator.pop(context);
  }

  void _submit(){
    Navigator.pop(context,_selectitems);
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Topics'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
            value: _selectitems.contains(item),
            title: Text(item),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (isChecked) => _itemchange(item, isChecked!),
          ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}




class dropdwn extends StatefulWidget {
  const dropdwn({Key? key}) : super(key: key);

  @override
  State<dropdwn> createState() => _dropdwnState();
}

class _dropdwnState extends State<dropdwn> {
  List<String> _selectitems=[];

  void _showmultiselect() async{

    final List<String> items=[
      'Flutter',
      'Node.js',
      'React Native',
      'Java',
      'Docker',
      'Mysql',
    ];
    final List<String>? results= await showDialog(
  context: context,
  builder: (BuildContext context){
    return multiselct(items: items);
  },
  );

    if(results!=null){
      setState(() {
  _selectitems =results;
      });
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multiselect"),

      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
                onPressed: _showmultiselect,

                child:Text("Select your fav Topic"),
            ),
            const Divider(
              height: 30,
            ),
            // display selected items
            Wrap(
              children: _selectitems
                  .map((e) => Chip(
                label: Text(e),
              ))
                  .toList(),
            )
          ],
        ),
      ),
    );

  }
}

