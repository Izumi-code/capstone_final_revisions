// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class CropCalendar extends StatefulWidget {
//   @override
//   _CropCalendarState createState() => _CropCalendarState();
// }

// class _CropCalendarState extends State<CropCalendar> {
//   final TextEditingController _cropNameController = TextEditingController();
//   final TextEditingController _locationController = TextEditingController();
//   final TextEditingController _notesController = TextEditingController();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   DateTime? _selectedDate;
//   String _cropStatus = 'Planning'; // Default status

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Plan and Manage Your Crops',
//       //       style: TextStyle(color: Colors.white)),
//       //   centerTitle: true,
//       //   backgroundColor: Colors.green,
//       // ),
//       appBar: AppBar(
//         backgroundColor: Colors.green[600],
//         leading: IconButton(
//           icon: Image.asset(
//             'assets/images/newimage/agrosense.png', // Replace with the actual path to your custom icon
//             width: 30, // Adjust the width as needed
//             height: 30, // Adjust the height as needed
//             // color: Colors.white,
//           ),
//           onPressed: () {
//             // Add functionality when the custom icon is pressed
//           },
//         ),
//         title: Text('AgroSense'), // Customize the app bar title
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               _buildSectionHeading('Basic Information'),
//               _buildTextField('Crop Name', _cropNameController),
//               _buildTextField('Location/Field Name', _locationController),
//               _buildDateField('Select Date Planted'),
//               _buildSelectedDateInfo(),
//               _buildTextField('Notes/Comments', _notesController),
//               _buildDropdown('Crop Status', _cropStatus, _onCropStatusChanged),
//               _buildButton('Save Crop', _addCrop),
//               SizedBox(height: 20),
//               _buildSectionHeading('Your Crops'),
//               _buildCropList(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionHeading(String title) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Text(
//         title,
//         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//       ),
//     );
//   }

//   Widget _buildTextField(String label, TextEditingController controller) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(),
//         ),
//       ),
//     );
//   }

//   Widget _buildDateField(String buttonText) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: ElevatedButton(
//         onPressed: () {
//           _selectDate(context);
//         },
//         style: ElevatedButton.styleFrom(primary: Colors.green),
//         child: Text(buttonText),
//       ),
//     );
//   }

//   Widget _buildSelectedDateInfo() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Text(
//         _selectedDate != null
//             ? 'Date Planted: ${_selectedDate!.toLocal()}'
//             : 'No Date Planted',
//         style: TextStyle(fontSize: 16),
//       ),
//     );
//   }

//   Widget _buildDropdown(
//       String label, String value, Function(String?) onChanged) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5.0),
//           color: Colors.grey[200], // Background color for the dropdown
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: DropdownButton<String>(
//             value: value,
//             onChanged: onChanged,
//             items: <String>['Planning', 'Planted', 'Harvested']
//                 .map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildButton(String buttonText, Function() onPressed) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(primary: Colors.green),
//       child: Text(buttonText),
//     );
//   }

//   Widget _buildCropList() {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _firestore
//           .collection('crops')
//           .where('userId', isEqualTo: _auth.currentUser?.uid)
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         }

//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return Center(child: Text('No crops available.'));
//         }

//         var crops = snapshot.data!.docs;
//         List<Widget> cropCards = [];

//         for (var crop in crops) {
//           var cropName = crop['name'];
//           var location = crop['location'];
//           var datePlanted = crop['datePlanted'] != null
//               ? (crop['datePlanted'] as Timestamp).toDate()
//               : null;
//           var status = crop['status'];
//           var cropId = crop.id;

//           var cropCard = GestureDetector(
//             onTap: () {
//               _navigateToCropDetails(context, cropId);
//             },
//             onLongPress: () {
//               _showDeleteConfirmationDialog(cropId);
//             },
//             child: Card(
//               elevation: 3,
//               margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//               child: ListTile(
//                 title: Text(cropName),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Location: $location'),
//                     Text(
//                         'Planted Date: ${datePlanted != null ? datePlanted.toLocal() : 'N/A'}'),
//                     Text('Status: $status'),
//                   ],
//                 ),
//               ),
//             ),
//           );
//           cropCards.add(cropCard);
//         }

//         return Column(
//           children: cropCards,
//         );
//       },
//     );
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );

//     if (pickedDate != null && pickedDate != _selectedDate) {
//       setState(() {
//         _selectedDate = pickedDate;
//       });
//     }
//   }

//   void _addCrop() {
//     String cropName = _cropNameController.text.trim();
//     String location = _locationController.text.trim();
//     String notes = _notesController.text.trim();

//     if (cropName.isNotEmpty && _selectedDate != null) {
//       _firestore.collection('crops').add({
//         'name': cropName,
//         'location': location,
//         'datePlanted': _selectedDate,
//         'notes': notes,
//         'status': _cropStatus,
//         'userId': _auth.currentUser?.uid,
//       });

//       _cropNameController.clear();
//       _locationController.clear();
//       _notesController.clear();
//       _selectedDate = null;
//       setState(() {
//         _cropStatus = 'Planning';
//       });
//     } else {
//       showErrorMessage("Crop name and date planted cannot be empty.");
//     }
//   }

//   void _onCropStatusChanged(String? newValue) {
//     setState(() {
//       _cropStatus = newValue ?? 'Planning';
//     });
//   }

//   void showErrorMessage(String message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: Colors.red,
//           title: Center(
//             child: Text(
//               message,
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _showDeleteConfirmationDialog(String cropId) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Delete Crop'),
//           content: Text('Are you sure you want to delete this crop?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // Close the dialog
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 _deleteCrop(cropId);
//                 Navigator.pop(context); // Close the dialog
//               },
//               child: Text('Delete'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _deleteCrop(String cropId) {
//     _firestore.collection('crops').doc(cropId).delete();
//   }

//   void _navigateToCropDetails(BuildContext context, String cropId) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => CropDetails(
//           context: context,
//           firestore: _firestore,
//           cropId: cropId,
//         ),
//       ),
//     );
//   }
// }

// // The rest of the code remains the same...

// class CropDetails extends StatelessWidget {
//   final BuildContext context;
//   final FirebaseFirestore firestore;
//   final String cropId;

//   CropDetails({
//     Key? key,
//     required this.context,
//     required this.firestore,
//     required this.cropId,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Crop Details', style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         backgroundColor: Colors.green,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.edit),
//             onPressed: () {
//               _navigateToEditCrop(context, cropId);
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 _navigateToAddActivity(context, cropId);
//               },
//               child: Text('Add Activity'),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Crop Information',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             StreamBuilder<DocumentSnapshot>(
//               stream: firestore.collection('crops').doc(cropId).snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 }

//                 if (!snapshot.hasData) {
//                   return Text('No crop information available.');
//                 }

//                 var cropData = snapshot.data!.data() as Map<String, dynamic>;
//                 var cropName = cropData['name'];
//                 var location = cropData['location'];
//                 var datePlanted = cropData['datePlanted'] != null
//                     ? (cropData['datePlanted'] as Timestamp).toDate()
//                     : null;
//                 var status = cropData['status'];

//                 return ListTile(
//                   title: Text('Crop Name: $cropName'),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Location: $location'),
//                       Text(
//                           'Planted Date: ${datePlanted != null ? datePlanted.toLocal() : 'N/A'}'),
//                       Text('Status: $status'),
//                     ],
//                   ),
//                 );
//               },
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Activities',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Expanded(
//               child: _buildActivityList(context),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildActivityList(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: firestore
//           .collection('crops')
//           .doc(cropId)
//           .collection('activities')
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         }

//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return Text('No activities available.');
//         }

//         var activities = snapshot.data!.docs;
//         List<Widget> activityCards = [];

//         for (var activity in activities) {
//           var activityName = activity['name'];
//           var activityNotes = activity['notes'];
//           var activityDate = activity['date'].toDate();
//           var activityId = activity.id;

//           var activityCard = Card(
//             elevation: 3,
//             margin: EdgeInsets.only(bottom: 16),
//             child: ListTile(
//               title: Text(activityName),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Notes: $activityNotes'),
//                   Text('Date: ${activityDate.toLocal()}'),
//                 ],
//               ),
//               trailing: IconButton(
//                 icon: Icon(Icons.delete),
//                 onPressed: () {
//                   _showDeleteActivityConfirmationDialog(cropId, activityId);
//                 },
//               ),
//             ),
//           );
//           activityCards.add(activityCard);
//         }

//         return ListView(
//           children: activityCards,
//         );
//       },
//     );
//   }

//   void _showDeleteActivityConfirmationDialog(String cropId, String activityId) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Delete Activity'),
//           content: Text('Are you sure you want to delete this activity?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // Close the dialog
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 _deleteActivity(cropId, activityId);
//                 Navigator.pop(context); // Close the dialog
//               },
//               child: Text('Delete'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _deleteActivity(String cropId, String activityId) {
//     firestore
//         .collection('crops')
//         .doc(cropId)
//         .collection('activities')
//         .doc(activityId)
//         .delete();
//   }

//   void _navigateToEditCrop(BuildContext context, String cropId) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => EditCropScreen(
//           context: context,
//           firestore: firestore,
//           cropId: cropId,
//         ),
//       ),
//     );
//   }

//   void _navigateToAddActivity(BuildContext context, String cropId) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AddActivityScreen(
//           context: context,
//           firestore: firestore,
//           cropId: cropId,
//         ),
//       ),
//     );
//   }
// }

// class EditCropScreen extends StatefulWidget {
//   final BuildContext context;
//   final FirebaseFirestore firestore;
//   final String cropId;

//   const EditCropScreen({
//     Key? key,
//     required this.context,
//     required this.firestore,
//     required this.cropId,
//   }) : super(key: key);

//   @override
//   _EditCropScreenState createState() => _EditCropScreenState();
// }

// class _EditCropScreenState extends State<EditCropScreen> {
//   final TextEditingController _cropNameController = TextEditingController();
//   final TextEditingController _locationController = TextEditingController();
//   DateTime? _selectedDate;
//   String _cropStatus = 'Planning'; // Default status

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Crop'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _cropNameController,
//               decoration: InputDecoration(
//                 labelText: 'Edit Crop Name',
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: _locationController,
//               decoration: InputDecoration(
//                 labelText: 'Edit Location/Field Name',
//               ),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {
//                 _selectDate(context);
//               },
//               child: Text('Edit Date Planted'),
//             ),
//             SizedBox(height: 10),
//             Text(
//               _selectedDate != null
//                   ? 'Date Planted: ${_selectedDate!.toLocal()}'
//                   : 'No Date Planted',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 10),
//             DropdownButton<String>(
//               value: _cropStatus,
//               onChanged: (String? newValue) {
//                 setState(() {
//                   _cropStatus = newValue!;
//                 });
//               },
//               items: <String>['Planning', 'Planted', 'Harvested']
//                   .map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 _editCrop();
//               },
//               child: Text('Save Changes'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );

//     if (pickedDate != null && pickedDate != _selectedDate) {
//       setState(() {
//         _selectedDate = pickedDate;
//       });
//     }
//   }

//   void _editCrop() {
//     String cropName = _cropNameController.text.trim();
//     String location = _locationController.text.trim();

//     Map<String, dynamic> updateData = {};

//     if (cropName.isNotEmpty) {
//       updateData['name'] = cropName;
//     }

//     if (_selectedDate != null) {
//       updateData['datePlanted'] = _selectedDate;
//     }

//     if (location.isNotEmpty) {
//       updateData['location'] = location;
//     }

//     updateData['status'] = _cropStatus;

//     widget.firestore.collection('crops').doc(widget.cropId).update(updateData);

//     Navigator.pop(context); // Close the edit crop screen
//   }

//   void showErrorMessage(String message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: Colors.red,
//           title: Center(
//             child: Text(
//               message,
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class AddActivityScreen extends StatefulWidget {
//   final BuildContext context;
//   final FirebaseFirestore firestore;
//   final String cropId;

//   const AddActivityScreen({
//     Key? key,
//     required this.context,
//     required this.firestore,
//     required this.cropId,
//   }) : super(key: key);

//   @override
//   _AddActivityScreenState createState() => _AddActivityScreenState();
// }

// class _AddActivityScreenState extends State<AddActivityScreen> {
//   final TextEditingController _activityNameController = TextEditingController();
//   final TextEditingController _activityNotesController =
//       TextEditingController();
//   DateTime? _selectedDate;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Activity'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _activityNameController,
//               decoration: InputDecoration(
//                 labelText: 'Activity Name',
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: _activityNotesController,
//               decoration: InputDecoration(
//                 labelText: 'Activity Notes',
//               ),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {
//                 _selectDate(context);
//               },
//               child: Text('Select Date'),
//             ),
//             SizedBox(height: 10),
//             Text(
//               _selectedDate != null
//                   ? 'Selected Date: ${_selectedDate!.toLocal()}'
//                   : 'No Date Selected',
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 _addActivity();
//               },
//               child: Text('Add Activity'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );

//     if (pickedDate != null && pickedDate != _selectedDate) {
//       setState(() {
//         _selectedDate = pickedDate;
//       });
//     }
//   }

//   void _addActivity() {
//     String activityName = _activityNameController.text;
//     String activityNotes = _activityNotesController.text;

//     if (_selectedDate != null) {
//       widget.firestore
//           .collection('crops')
//           .doc(widget.cropId)
//           .collection('activities')
//           .add({
//         'name': activityName,
//         'notes': activityNotes,
//         'date': _selectedDate,
//       });

//       Navigator.pop(context); // Close the add activity screen
//     } else {
//       // Handle case where no date is selected
//       // You might want to show a message to the user
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CropCalendar extends StatefulWidget {
  @override
  _CropCalendarState createState() => _CropCalendarState();
}

class _CropCalendarState extends State<CropCalendar> {
  final TextEditingController _cropNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DateTime? _selectedDate;
  String _cropStatus = 'Planning'; // Default status

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        leading: IconButton(
          icon: Image.asset(
            'assets/images/newimage/agrosense.png',
            width: 30,
            height: 30,
          ),
          onPressed: () {},
        ),
        title: Text('AgroSense'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionHeading('Basic Information'),
              _buildTextField('Crop Name', _cropNameController),
              _buildTextField('Location/Field Name', _locationController),
              _buildDateField('Select Date Planted'),
              _buildSelectedDateInfo(),
              _buildTextField('Notes/Comments', _notesController),
              _buildDropdown('Crop Status', _cropStatus, _onCropStatusChanged),
              _buildButton('Save Crop', _addCrop),
              SizedBox(height: 20),
              _buildSectionHeading('Your Crops'),
              _buildCropList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeading(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDateField(String buttonText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        onPressed: () {
          _selectDate(context);
        },
        style: ElevatedButton.styleFrom(primary: Colors.green),
        child: Text(buttonText),
      ),
    );
  }

  Widget _buildSelectedDateInfo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        _selectedDate != null
            ? 'Date Planted: ${_selectedDate!.toLocal()}'
            : 'No Date Planted',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildDropdown(
      String label, String value, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.grey[200],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButtonFormField<String>(
            value: value,
            onChanged: onChanged,
            items: <String>['Planning', 'Planted', 'Harvested']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String buttonText, Function() onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(primary: Colors.green),
      child: Text(buttonText),
    );
  }

  Widget _buildCropList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('crops')
          .where('userId', isEqualTo: _auth.currentUser?.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No crops available.'));
        }

        var crops = snapshot.data!.docs;
        List<Widget> cropCards = [];

        for (var crop in crops) {
          var cropName = crop['name'];
          var location = crop['location'];
          var datePlanted = crop['datePlanted'] != null
              ? (crop['datePlanted'] as Timestamp).toDate()
              : null;
          var status = crop['status'];
          var cropId = crop.id;

          var cropCard = GestureDetector(
            onTap: () {
              _navigateToCropDetails(context, cropId);
            },
            onLongPress: () {
              _showDeleteConfirmationDialog(cropId);
            },
            child: Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Text(cropName),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Location: $location'),
                    Text(
                        'Planted Date: ${datePlanted != null ? datePlanted.toLocal() : 'N/A'}'),
                    Text('Status: $status'),
                  ],
                ),
              ),
            ),
          );
          cropCards.add(cropCard);
        }

        return Column(
          children: cropCards,
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _addCrop() {
    String cropName = _cropNameController.text.trim();
    String location = _locationController.text.trim();
    String notes = _notesController.text.trim();

    if (cropName.isNotEmpty && _selectedDate != null) {
      _firestore.collection('crops').add({
        'name': cropName,
        'location': location,
        'datePlanted': _selectedDate,
        'notes': notes,
        'status': _cropStatus,
        'userId': _auth.currentUser?.uid,
      });

      _cropNameController.clear();
      _locationController.clear();
      _notesController.clear();
      _selectedDate = null;
      setState(() {
        _cropStatus = 'Planning';
      });
    } else {
      showErrorMessage("Crop name and date planted cannot be empty.");
    }
  }

  void _onCropStatusChanged(String? newValue) {
    setState(() {
      _cropStatus = newValue ?? 'Planning';
    });
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.red,
          title: Center(
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(String cropId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Crop'),
          content: Text('Are you sure you want to delete this crop?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteCrop(cropId);
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteCrop(String cropId) {
    _firestore.collection('crops').doc(cropId).delete();
  }

  void _navigateToCropDetails(BuildContext context, String cropId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CropDetails(
          context: context,
          firestore: _firestore,
          cropId: cropId,
        ),
      ),
    );
  }
}

// The rest of the code remains the same...

class CropDetails extends StatelessWidget {
  final BuildContext context;
  final FirebaseFirestore firestore;
  final String cropId;

  CropDetails({
    Key? key,
    required this.context,
    required this.firestore,
    required this.cropId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Details', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _navigateToEditCrop(context, cropId);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                _navigateToAddActivity(context, cropId);
              },
              child: Text('Add Activity'),
            ),
            SizedBox(height: 20),
            Text(
              'Crop Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            StreamBuilder<DocumentSnapshot>(
              stream: firestore.collection('crops').doc(cropId).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (!snapshot.hasData) {
                  return Text('No crop information available.');
                }

                var cropData = snapshot.data!.data() as Map<String, dynamic>;
                var cropName = cropData['name'];
                var location = cropData['location'];
                var datePlanted = cropData['datePlanted'] != null
                    ? (cropData['datePlanted'] as Timestamp).toDate()
                    : null;
                var status = cropData['status'];

                return ListTile(
                  title: Text('Crop Name: $cropName'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Location: $location'),
                      Text(
                          'Planted Date: ${datePlanted != null ? datePlanted.toLocal() : 'N/A'}'),
                      Text('Status: $status'),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              'Activities',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: _buildActivityList(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection('crops')
          .doc(cropId)
          .collection('activities')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No activities available.');
        }

        var activities = snapshot.data!.docs;
        List<Widget> activityCards = [];

        for (var activity in activities) {
          var activityName = activity['name'];
          var activityNotes = activity['notes'];
          var activityDate = activity['date'].toDate();
          var activityId = activity.id;

          var activityCard = Card(
            elevation: 3,
            margin: EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text(activityName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Notes: $activityNotes'),
                  Text('Date: ${activityDate.toLocal()}'),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _showDeleteActivityConfirmationDialog(cropId, activityId);
                },
              ),
            ),
          );
          activityCards.add(activityCard);
        }

        return ListView(
          children: activityCards,
        );
      },
    );
  }

  void _showDeleteActivityConfirmationDialog(String cropId, String activityId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Activity'),
          content: Text('Are you sure you want to delete this activity?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteActivity(cropId, activityId);
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteActivity(String cropId, String activityId) {
    firestore
        .collection('crops')
        .doc(cropId)
        .collection('activities')
        .doc(activityId)
        .delete();
  }

  void _navigateToEditCrop(BuildContext context, String cropId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditCropScreen(
          context: context,
          firestore: firestore,
          cropId: cropId,
        ),
      ),
    );
  }

  void _navigateToAddActivity(BuildContext context, String cropId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddActivityScreen(
          context: context,
          firestore: firestore,
          cropId: cropId,
        ),
      ),
    );
  }
}

class EditCropScreen extends StatefulWidget {
  final BuildContext context;
  final FirebaseFirestore firestore;
  final String cropId;

  const EditCropScreen({
    Key? key,
    required this.context,
    required this.firestore,
    required this.cropId,
  }) : super(key: key);

  @override
  _EditCropScreenState createState() => _EditCropScreenState();
}

class _EditCropScreenState extends State<EditCropScreen> {
  final TextEditingController _cropNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  DateTime? _selectedDate;
  String _cropStatus = 'Planning'; // Default status

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Crop'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cropNameController,
              decoration: InputDecoration(
                labelText: 'Edit Crop Name',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Edit Location/Field Name',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _selectDate(context);
              },
              child: Text('Edit Date Planted'),
            ),
            SizedBox(height: 10),
            Text(
              _selectedDate != null
                  ? 'Date Planted: ${_selectedDate!.toLocal()}'
                  : 'No Date Planted',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: _cropStatus,
              onChanged: (String? newValue) {
                setState(() {
                  _cropStatus = newValue!;
                });
              },
              items: <String>['Planning', 'Planted', 'Harvested']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _editCrop();
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _editCrop() {
    String cropName = _cropNameController.text.trim();
    String location = _locationController.text.trim();

    Map<String, dynamic> updateData = {};

    if (cropName.isNotEmpty) {
      updateData['name'] = cropName;
    }

    if (_selectedDate != null) {
      updateData['datePlanted'] = _selectedDate;
    }

    if (location.isNotEmpty) {
      updateData['location'] = location;
    }

    updateData['status'] = _cropStatus;

    widget.firestore.collection('crops').doc(widget.cropId).update(updateData);

    Navigator.pop(context); // Close the edit crop screen
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.red,
          title: Center(
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}

class AddActivityScreen extends StatefulWidget {
  final BuildContext context;
  final FirebaseFirestore firestore;
  final String cropId;

  const AddActivityScreen({
    Key? key,
    required this.context,
    required this.firestore,
    required this.cropId,
  }) : super(key: key);

  @override
  _AddActivityScreenState createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  final TextEditingController _activityNameController = TextEditingController();
  final TextEditingController _activityNotesController =
      TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Activity'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _activityNameController,
              decoration: InputDecoration(
                labelText: 'Activity Name',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _activityNotesController,
              decoration: InputDecoration(
                labelText: 'Activity Notes',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _selectDate(context);
              },
              child: Text('Select Date'),
            ),
            SizedBox(height: 10),
            Text(
              _selectedDate != null
                  ? 'Selected Date: ${_selectedDate!.toLocal()}'
                  : 'No Date Selected',
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _addActivity();
              },
              child: Text('Add Activity'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _addActivity() {
    String activityName = _activityNameController.text;
    String activityNotes = _activityNotesController.text;

    if (_selectedDate != null) {
      widget.firestore
          .collection('crops')
          .doc(widget.cropId)
          .collection('activities')
          .add({
        'name': activityName,
        'notes': activityNotes,
        'date': _selectedDate,
      });

      Navigator.pop(context); // Close the add activity screen
    } else {
      // Handle case where no date is selected
      // You might want to show a message to the user
    }
  }
}
