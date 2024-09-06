import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);
  static String verify = "";

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController phoneController = TextEditingController();
  String phone = "";
  bool isLoading = false; // Add a loading state

  @override
  void initState() {
    super.initState();
    phoneController.text = "+91"; // Default country code
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/img1.png', width: 150, height: 150),
              const SizedBox(height: 25),
              const Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "We need to register your phone before getting started!",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Text("|", style: TextStyle(fontSize: 33, color: Colors.grey)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        onChanged: (value) => phone = value,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone",
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () async {
                    if (phone.isNotEmpty) {
                      setState(() {
                        isLoading = true; // Show loading state
                      });
                      try {
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: '${phoneController.text + phone}',
                          verificationCompleted: (PhoneAuthCredential credential) async {
                            // Automatically sign the user in
                            await FirebaseAuth.instance.signInWithCredential(credential);
                          },
                          verificationFailed: (FirebaseAuthException e) {
                            setState(() {
                              isLoading = false; // Stop loading
                            });
                            print("222${e.message}");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Verification Failed: ${e.message}")),

                            );
                          },
                          codeSent: (String verificationId, int? resendToken) {
                            setState(() {
                              isLoading = false; // Stop loading
                            });
                            MyPhone.verify = verificationId;
                           // Navigator.pushNamed(context, 'verify');
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {
                            setState(() {
                              isLoading = false; // Stop loading
                            });
                          },
                        );
                      } catch (e) {
                        setState(() {
                          isLoading = false; // Stop loading
                        });
                        print("Error: $e");
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please enter a valid phone number"))
                      );
                    }
                  },
                  child: isLoading ? CircularProgressIndicator() : Text("Send the code"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
