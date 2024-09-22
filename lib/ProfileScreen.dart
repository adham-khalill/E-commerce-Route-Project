import 'package:flutter/material.dart';
import 'Api/ApiManger.dart';
import 'jsonFiles/Response/addressResponse.dart';

class ProfileScreen extends StatefulWidget {
  final String token;  // Pass the token from the logged-in user

  ProfileScreen({required this.token});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = true;
  AddressResponse? _addressResponse;
  String userName = "Not found";  // Default "Not found"
  String email = "Not found";  // Default "Not found"
  String mobile = "Not found";  // Default "Not found"
  String addressDetails = "Not found";  // Default for address

  @override
  void initState() {
    super.initState();
    _fetchUserAddress();
  }

  Future<void> _fetchUserAddress() async {
    final addressResponse = await ApiManager.fetchUserAddress(widget.token);
    if (addressResponse != null && addressResponse.data != null && addressResponse.data!.isNotEmpty) {
      final address = addressResponse.data!.first;  // Assuming one address
      setState(() {
        addressDetails = '${address.details}, ${address.city}';
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;  // Set to false but no address found
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xFF003366),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, $userName',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF003366)),
            ),
            SizedBox(height: 8),
            Text(
              email,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            _buildProfileField('Your full name', userName, false),
            SizedBox(height: 15),
            _buildProfileField('Your E-mail', email, false),
            SizedBox(height: 15),
            _buildProfileField('Your password', '****************', true),  // Masked password
            SizedBox(height: 15),
            _buildProfileField('Your mobile number', mobile, false),
            SizedBox(height: 15),
            _buildAddressSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, String value, bool isPassword) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF003366)),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF003366), width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              Icon(Icons.edit, color: Color(0xFF003366)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddressSection() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        Text(
          'Your Address',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF003366)),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF003366), width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  addressDetails,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              Icon(Icons.edit, color: Color(0xFF003366)),
            ],
          ),
        ),
      ],
    );
  }
}
