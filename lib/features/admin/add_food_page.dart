import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../constants/text_font.dart';

class AddFoodPage extends StatefulWidget {
  const AddFoodPage({super.key});

  @override
  State<AddFoodPage> createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  String selectedCategory = 'pizza';
  File? selectedImage;
  bool isLoading = false;

  final String cloudinaryCloudName = "";
  final String cloudinaryUploadPreset = "";

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }


  Future<String?> uploadToCloudinary(File file) async {
    final url = Uri.parse("https://api.cloudinary.com/v1_1/$cloudinaryCloudName/image/upload");

    final request = http.MultipartRequest("POST", url)
      ..fields['upload_preset'] = cloudinaryUploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', file.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final jsonMap = jsonDecode(responseData);
      return jsonMap['secure_url'];
    } else {
      debugPrint("Cloudinary Upload Failure Code: ${response.statusCode}");
      return null;
    }
  }

  Future<void> saveFoodToFirestore() async {
    if (!_formKey.currentState!.validate() || selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill out all fields and select a food photo")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final String? imageUrl = await uploadToCloudinary(selectedImage!);

      if (imageUrl == null) {
        throw Exception("Failed to host your image asset on Cloudinary.");
      }

      await FirebaseFirestore.instance.collection('food_items').add({
        'title': titleController.text.trim(),
        'description': descriptionController.text.trim(),
        'price': double.parse(priceController.text.trim()),
        'category': selectedCategory,
        'imageUrl': imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Delicious food item published successfully! 🎉")),
      );

      // Clean form state up on completion
      _formKey.currentState!.reset();
      setState(() {
        selectedImage = null;
      });
    } catch (e) {

        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error uploading: ${e.toString()}")),
      );

    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryOrange = Color(0xFFFF5722);
    const darkOnboard = Color(0xFF1E1E24);

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        title: Text("Add Food Item", style: AppBarTitleText.poppins.copyWith(color: Colors.white)),
        backgroundColor: darkOnboard,
        centerTitle: true,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: primaryOrange))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Uploader Canvas Frame
              GestureDetector(
                onTap: pickImage,
                child: Center(
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade200, width: 2),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10)
                      ],
                    ),
                    child: selectedImage != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.file(selectedImage!, fit: BoxFit.cover),
                    )
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_photo_alternate_rounded, size: 48, color: Colors.grey.shade400),
                        const SizedBox(height: 8),
                        Text("Upload Appetizing Food Photo", style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Inputs block
              buildLabel("FOOD NAME"),
              buildInputField(titleController, "e.g., Spicy Pepperoni Masterpiece"),
              const SizedBox(height: 20),

              buildLabel("PRICE (\$USD)"),
              buildInputField(priceController, "e.g., 14.99", isNumeric: true),
              const SizedBox(height: 20),

              buildLabel("DESCRIPTION"),
              buildInputField(descriptionController, "Describe flavors, ingredients, allergens...", maxLines: 3),
              const SizedBox(height: 20),

              buildLabel("CATEGORY"),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedCategory,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded, color: primaryOrange),
                    items: const [
                      DropdownMenuItem(value: 'pizza', child: Text("Pizza 🍕")),
                      DropdownMenuItem(value: 'burger', child: Text("Burger 🍔")),
                      DropdownMenuItem(value: 'chicken', child: Text("Chicken 🍗")),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => selectedCategory = val);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Submit Action Call
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: saveFoodToFirestore,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryOrange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 2,
                    shadowColor: primaryOrange.withValues(alpha: 0.4),
                  ),
                  child: const Text("Publish Item Live", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF555555), letterSpacing: 1.2)),
    );
  }

  Widget buildInputField(TextEditingController controller, String hint, {bool isNumeric = false, int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: isNumeric ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
      validator: (val) => val == null || val.trim().isEmpty ? "Field cannot be empty" : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(16),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: Colors.grey.shade200)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFFF5722), width: 1.5)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: Colors.redAccent.shade700)),
        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: Colors.redAccent.shade700, width: 1.5)),
      ),
    );
  }
}