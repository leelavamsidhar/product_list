import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../data/Models/products_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/order_bloc/order_bloc.dart';
import '../Bloc/order_bloc/order_event.dart';
import '../Bloc/order_bloc/order_state.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class OrderScreen extends StatefulWidget {
  Product product;
  OrderScreen({super.key, required this.product});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  late Razorpay _razorpay;
  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("payment is  Sucess ");
    context.read<OrderBloc>().add(
      PaymentSucess(
        paymentId: response.paymentId.toString(),
        orderId: response.orderId.toString(),
        orderDate: response.data.toString(),
      ),

    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("this is wallet ");
  }

  Widget textInputField(
    TextEditingController controller, {
    required String label,
    required String hint,
    bool isEmail = false,
    bool isPassword = false,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 16 : screenWidth * 0.2,
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic,
            fontSize: isSmallScreen ? 14 : 16,
          ),
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: isSmallScreen ? 14 : 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(isSmallScreen ? 15 : 25),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter $label";
          }
          if (isEmail && !emailRegex.hasMatch(value)) {
            return "Please enter a valid email";
          }
          if (isPassword && value.toString().length < 6) {
            return 'Please Enter the min 6 Carters';
          }
          return null;
        },
      ),
    );
  }

  void openCheckout({
    required double amount,
    required String name,
    required String mobile,
    required String email,
  }) {
    double finalAmount = amount * 80;
    var options = {

      'key': 'rzp_test_RswPiyx1RQgabT',
      'amount': finalAmount, // 500.00 INR
      'currency': 'INR',
      'name': name,
      'description': 'Fine T-Shirt',
      'timeout': 60,
      'prefill': {'contact': mobile, 'email': email},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Razorpay error: $e');
    }
  }

  @override
  void dispose() {
    name.dispose();
    mobile.dispose();
    email.dispose();
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book Order')),
      body: BlocConsumer<OrderBloc, OrderState>(
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 50,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),

                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: MediaQuery.of(context).size.height * 0.70,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primaryContainer.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.product.category!.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$${widget.product.price!.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            textInputField(
                              name,
                              label: "Full Name",
                              hint: "Rajesh",
                            ),
                            const SizedBox(height: 20),
                            textInputField(
                              mobile,
                              label: "Mobile",
                              hint: "9398326632",
                            ),
                            const SizedBox(height: 20),
                            textInputField(
                              email,
                              label: "Email",
                              hint: "example@gmail.com",
                              isEmail: true,
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<OrderBloc>().add(
                                      FormChange(
                                        productName: widget.product.category
                                            .toString(),
                                        amount: widget.product.price!
                                            .toDouble(),
                                        email: email.text,
                                        mobile: mobile.text,
                                        name: name.text,
                                      ),
                                    );
                                    context.read<OrderBloc>().add(FormSubmit());
                                  }
                                },
                                child: state.status == FormStatus.loading
                                    ? CircularProgressIndicator()
                                    : Text(
                                        'Book Now',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor:
                                      Colors.white, // Text/icon color
                                  backgroundColor:
                                      Colors.green.shade300, // Background color
                                  elevation: 8.0, // Shadow elevation
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 15,
                                  ), // Padding
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state.status == FormStatus.enablePayment) {
            openCheckout(
              name: state.name,
              mobile: state.mobile,
              email: state.email,
              amount: state.amount,
            );
          }
        },
      ),
    );
  }
}
