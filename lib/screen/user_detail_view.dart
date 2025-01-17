import 'package:flutter/material.dart';
import 'package:resturant/api/api.dart';
import 'package:resturant/components/colors.dart';
import 'package:resturant/models/user_list_model.dart';
import 'package:resturant/screen/edit_users_view.dart';

class UserDetailScreen extends StatefulWidget {
  final UsersList user;

  const UserDetailScreen({super.key, required this.user});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Perform any initialization logic here
    debugPrint('UserDetailScreen initialized for ${widget.user.username}');
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${user.firstName ?? 'User'} ${user.lastName ?? 'Details'}",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditUserScreen(user: user),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.1,
            child: Image.asset(
              'assets/icons/Business.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                  child: user.image != null
                      ? CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              NetworkImage("${Api.mediaUrl}${user.image!}"),
                        )
                      : const CircleAvatar(
                          radius: 60,
                          child: Icon(Icons.person, size: 60),
                        ),
                ),
                const SizedBox(height: 20),
                GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.0,
                  ),
                  children: [
                    _buildSectionCard(
                      "Basic Information",
                      [
                        _buildInfoRow("Username", user.username),
                        _buildInfoRow("Email", user.email),
                        _buildInfoRow("Phone", user.phoneNumber),
                        _buildInfoRow("Address", user.address),
                        _buildInfoRow("Role", user.role),
                        _buildInfoRow("Active", user.isActive?.toString()),
                      ],
                    ),
                    _buildSectionCard(
                      "Government Details",
                      [
                        _buildInfoRow("PAN Card Number", user.panCard),
                        _buildInfoRow("Citizenship Number", user.citizenship),
                        if (user.citizenshipImage != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Image.network(
                              "${Api.mediaUrl}${user.citizenshipImage!}",
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                      ],
                    ),
                    _buildSectionCard(
                      "Employment Details",
                      [
                        _buildInfoRow("Employee ID", user.employeeId),
                        _buildInfoRow("Employee Type", user.employeeType),
                        _buildInfoRow("Branch", user.branch),
                        _buildInfoRow(
                          "Joined Date",
                          user.dateJoined != null
                              ? user.dateJoined!.toLocal().toString().split(' ')[0]
                              : "Not Available",
                        ),
                      ],
                    ),
                    _buildSectionCard(
                      "Bank Details",
                      [
                        _buildInfoRow("Bank", user.bankName),
                        _buildInfoRow("Account Number", user.bankAccountNumber),
                      ],
                    ),
                    _buildSectionCard(
                      "Health Details",
                      [
                        _buildInfoRow("Blood Group", user.bloodGroup),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(String title, List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label:",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value ?? "Not Available",
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
