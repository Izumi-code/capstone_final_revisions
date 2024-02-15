import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PlantingEntry {
  final String id;
  String cropName;
  String plantingDate;
  String location;
  String variety;
  String plantingMethod;
  String spacings;
  String soilType;
  String fertilizerUsed;
  String notes;
  DateTime createdAt; // Add this field

  PlantingEntry({
    required this.id,
    required this.cropName,
    required this.plantingDate,
    this.location = '',
    this.variety = '',
    this.plantingMethod = '',
    this.spacings = '',
    this.soilType = '',
    this.fertilizerUsed = '',
    this.notes = '',
    required this.createdAt, // Add this field
  });
}

class PlantingLogFeature extends StatefulWidget {
  @override
  _PlantingLogFeatureState createState() => _PlantingLogFeatureState();
}

class _PlantingLogFeatureState extends State<PlantingLogFeature> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _cropNameController = TextEditingController();
  final TextEditingController _plantingDateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _varietyController = TextEditingController();
  final TextEditingController _plantingMethodController =
      TextEditingController();
  final TextEditingController _spacingsController = TextEditingController();
  final TextEditingController _soilTypeController = TextEditingController();
  final TextEditingController _fertilizerUsedController =
      TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  List<PlantingEntry> entries = [];

  @override
  void initState() {
    super.initState();
    _loadPlantingLogEntries();
  }

  void _loadPlantingLogEntries() {
    final user = _auth.currentUser;
    if (user != null) {
      final userID = user.uid;
      _firestore
          .collection('planting_logs')
          .doc(userID)
          .collection('entries')
          .get()
          .then((querySnapshot) {
        if (mounted) {
          setState(() {
            entries = querySnapshot.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return PlantingEntry(
                id: doc.id,
                cropName: data['cropName'],
                plantingDate: data['plantingDate'],
                location: data['location'],
                variety: data['variety'],
                plantingMethod: data['plantingMethod'],
                spacings: data['spacings'],
                soilType: data['soilType'],
                fertilizerUsed: data['fertilizerUsed'],
                notes: data['notes'],
                createdAt: data['createdAt'] ?? DateTime.now(),
              );
            }).toList();
          });
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _addPlantingLogEntry(PlantingEntry entry) {
    final user = _auth.currentUser;
    if (user != null) {
      final userID = user.uid;
      final userEmail = user.email;
      final userRef = _firestore.collection('planting_logs').doc(userID);

      userRef.collection('entries').add({
        'cropName': entry.cropName,
        'plantingDate': entry.plantingDate,
        'location': entry.location,
        'variety': entry.variety,
        'plantingMethod': entry.plantingMethod,
        'spacings': entry.spacings,
        'soilType': entry.soilType,
        'fertilizerUsed': entry.fertilizerUsed,
        'notes': entry.notes,
      }).then((_) {
        userRef.set({'email': userEmail}, SetOptions(merge: true));
        _loadPlantingLogEntries();
      });
    }
  }

  void _editPlantingLogEntry(PlantingEntry entry) {
    final user = _auth.currentUser;
    if (user != null) {
      final userID = user.uid;
      final userEmail = user.email;
      final userRef = _firestore.collection('planting_logs').doc(userID);

      userRef.collection('entries').doc(entry.id).update({
        'cropName': entry.cropName,
        'plantingDate': entry.plantingDate,
        'location': entry.location,
        'variety': entry.variety,
        'plantingMethod': entry.plantingMethod,
        'spacings': entry.spacings,
        'soilType': entry.soilType,
        'fertilizerUsed': entry.fertilizerUsed,
        'notes': entry.notes,
      }).then((_) {
        userRef.set({'email': userEmail}, SetOptions(merge: true));
        _loadPlantingLogEntries();
      });
    }
  }

  void _deletePlantingLogEntry(PlantingEntry entry) {
    final user = _auth.currentUser;
    if (user != null) {
      final userID = user.uid;
      final userRef = _firestore.collection('planting_logs').doc(userID);

      userRef.collection('entries').doc(entry.id).delete().then((_) {
        _loadPlantingLogEntries();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Planting Log"),
      //   backgroundColor: Colors.green,
      // ),
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        leading: IconButton(
          icon: Image.asset(
            'assets/images/newimage/agrosense.png', // Replace with the actual path to your custom icon
            width: 30, // Adjust the width as needed
            height: 30, // Adjust the height as needed
            // color: Colors.white,
          ),
          onPressed: () {
            // Add functionality when the custom icon is pressed
          },
        ),
        title: Text('AgroSense'), // Customize the app bar title
      ),
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _showLogDetails(entries[index]);
            },
            child: PlantingCard(entry: entries[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add Planting Log Entry'),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: _cropNameController,
                        decoration: InputDecoration(labelText: 'Crop Name'),
                      ),
                      TextField(
                        controller: _plantingDateController,
                        decoration: InputDecoration(labelText: 'Planting Date'),
                      ),
                      TextField(
                        controller: _locationController,
                        decoration: InputDecoration(labelText: 'Location'),
                      ),
                      TextField(
                        controller: _varietyController,
                        decoration: InputDecoration(labelText: 'Variety'),
                      ),
                      TextField(
                        controller: _plantingMethodController,
                        decoration:
                            InputDecoration(labelText: 'Planting Method'),
                      ),
                      TextField(
                        controller: _spacingsController,
                        decoration: InputDecoration(labelText: 'Spacings'),
                      ),
                      TextField(
                        controller: _soilTypeController,
                        decoration: InputDecoration(labelText: 'Soil Type'),
                      ),
                      TextField(
                        controller: _fertilizerUsedController,
                        decoration:
                            InputDecoration(labelText: 'Fertilizer Used'),
                      ),
                      TextField(
                        controller: _notesController,
                        decoration: InputDecoration(labelText: 'Notes'),
                      ),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      final newEntry = PlantingEntry(
                        id: '',
                        cropName: _cropNameController.text,
                        plantingDate: _plantingDateController.text,
                        location: _locationController.text,
                        variety: _varietyController.text,
                        plantingMethod: _plantingMethodController.text,
                        spacings: _spacingsController.text,
                        soilType: _soilTypeController.text,
                        fertilizerUsed: _fertilizerUsedController.text,
                        notes: _notesController.text,
                        createdAt: DateTime.now(),
                      );
                      _addPlantingLogEntry(newEntry);
                      _cropNameController.clear();
                      _plantingDateController.clear();
                      _locationController.clear();
                      _varietyController.clear();
                      _plantingMethodController.clear();
                      _spacingsController.clear();
                      _soilTypeController.clear();
                      _fertilizerUsedController.clear();
                      _notesController.clear();
                      Navigator.pop(context);
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showLogDetails(PlantingEntry entry) {
    TextEditingController _editedCropNameController =
        TextEditingController(text: entry.cropName);
    TextEditingController _editedPlantingDateController =
        TextEditingController(text: entry.plantingDate);
    TextEditingController _editedLocationController =
        TextEditingController(text: entry.location);
    TextEditingController _editedVarietyController =
        TextEditingController(text: entry.variety);
    TextEditingController _editedPlantingMethodController =
        TextEditingController(text: entry.plantingMethod);
    TextEditingController _editedSpacingsController =
        TextEditingController(text: entry.spacings);
    TextEditingController _editedSoilTypeController =
        TextEditingController(text: entry.soilType);
    TextEditingController _editedFertilizerUsedController =
        TextEditingController(text: entry.fertilizerUsed);
    TextEditingController _editedNotesController =
        TextEditingController(text: entry.notes);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Log Entry'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _editedCropNameController,
                  decoration: InputDecoration(labelText: 'Crop Name'),
                ),
                TextField(
                  controller: _editedPlantingDateController,
                  decoration: InputDecoration(labelText: 'Planting Date'),
                ),
                TextField(
                  controller: _editedLocationController,
                  decoration: InputDecoration(labelText: 'Location'),
                ),
                TextField(
                  controller: _editedVarietyController,
                  decoration: InputDecoration(labelText: 'Variety'),
                ),
                TextField(
                  controller: _editedPlantingMethodController,
                  decoration: InputDecoration(labelText: 'Planting Method'),
                ),
                TextField(
                  controller: _editedSpacingsController,
                  decoration: InputDecoration(labelText: 'Spacings'),
                ),
                TextField(
                  controller: _editedSoilTypeController,
                  decoration: InputDecoration(labelText: 'Soil Type'),
                ),
                TextField(
                  controller: _editedFertilizerUsedController,
                  decoration: InputDecoration(labelText: 'Fertilizer Used'),
                ),
                TextField(
                  controller: _editedNotesController,
                  decoration: InputDecoration(labelText: 'Notes'),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                entry.cropName = _editedCropNameController.text;
                entry.plantingDate = _editedPlantingDateController.text;
                entry.location = _editedLocationController.text;
                entry.variety = _editedVarietyController.text;
                entry.plantingMethod = _editedPlantingMethodController.text;
                entry.spacings = _editedSpacingsController.text;
                entry.soilType = _editedSoilTypeController.text;
                entry.fertilizerUsed = _editedFertilizerUsedController.text;
                entry.notes = _editedNotesController.text;

                _editPlantingLogEntry(entry);

                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
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
      color: Colors.lightGreen[100], // Adjust the card color
      elevation: 4, // Add elevation for a slight shadow effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Add rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry.cropName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green[800], // Darken the text color
                fontSize: 20,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Planted on: ${entry.plantingDate}",
              style: TextStyle(color: Colors.green[700]),
            ),
            SizedBox(height: 16),
            _buildDetailRow("Location", entry.location),
            _buildDetailRow("Variety", entry.variety),
            _buildDetailRow("Planting Method", entry.plantingMethod),
            _buildDetailRow("Spacings", entry.spacings),
            _buildDetailRow("Soil Type", entry.soilType),
            _buildDetailRow("Fertilizer Used", entry.fertilizerUsed),
            _buildDetailRow("Notes", entry.notes),
            SizedBox(height: 8),
            Text(
              "Created on: ${entry.createdAt.toString()}",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildDetailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    ),
  );
}
