import 'package:flutter/material.dart';

class PlantLogScreen extends StatefulWidget {
  @override
  _PlantLogScreenState createState() => _PlantLogScreenState();
}

class _PlantLogScreenState extends State<PlantLogScreen> {
  List<PlantingEntry> entries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Farmer's Plant Log"),
      ),
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return PlantingCard(entry: entries[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to a new entry form screen.
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NewPlantEntryForm(),
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class PlantingCard extends StatelessWidget {
  final PlantingEntry entry;

  PlantingCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        title: Text(entry.cropName),
        subtitle: Text("Planted on: ${entry.plantingDate}"),
      ),
    );
  }
}

class PlantingEntry {
  final String cropName;
  final String plantingDate;

  PlantingEntry({required this.cropName, required this.plantingDate});
}

class NewPlantEntryForm extends StatefulWidget {
  @override
  _NewPlantEntryFormState createState() => _NewPlantEntryFormState();
}

class _NewPlantEntryFormState extends State<NewPlantEntryForm> {
  final _formKey = GlobalKey<FormState>();
  String cropName = "";
  String plantingDate = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Entry"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "Crop Name"),
                onSaved: (value) => cropName = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the crop name";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Planting Date"),
                onSaved: (value) => plantingDate = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the planting date";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Add the new entry to the list or database.
                    // For simplicity, we'll just print the values.
                    print("Crop Name: $cropName, Planting Date: $plantingDate");
                    Navigator.of(context)
                        .pop(); // Go back to the previous screen.
                  }
                },
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
