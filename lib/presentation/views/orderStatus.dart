import 'package:flutter/material.dart';
import '/infrastructure/models/orderModel.dart';
import '/presentation/elements/dynamicFontSize.dart';
import '/presentation/elements/heigh_sized_box.dart';

class OrderStatus extends StatefulWidget {
  final OrderDetailsModel oderModel;

  OrderStatus(this.oderModel);

  @override
  _OrderStatusState createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  // UpdateProductRatingLogic _updateProductRatingLogic =
  //     UpdateProductRatingLogic();

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  @override
  initState() {
    if (widget.oderModel.isPending!) {
      tapped(0);
    } else if (widget.oderModel.isActive!) {
      tapped(1);
    } else if (widget.oderModel.isComplete!) {
      tapped(2);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Order Status'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                type: stepperType,
                physics: ScrollPhysics(),
                currentStep: _currentStep,
                // controlsBuilder: (BuildContext context,
                //     {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                //   return Row(
                //     children: <Widget>[],
                //   );
                // },
                steps: <Step>[
                  Step(
                    title: new Text('Order Placed'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        DynamicFontSize(
                          label: "Order Placed",
                        ),
                        DynamicFontSize(
                          label: widget.oderModel.placementDate!,
                        ),
                      ],
                    ),
                    isActive: true,
                    state: StepState.complete,
                  ),
                  Step(
                    title: new Text('Order Processed'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        DynamicFontSize(
                          label: "Order is being processed.",
                        ),
                        DynamicFontSize(
                          label: widget.oderModel.processedDate ?? "",
                        ),
                      ],
                    ),
                    isActive: widget.oderModel.isComplete!
                        ? true
                        : widget.oderModel.isReady!
                            ? true
                            : widget.oderModel.isActive!,
                    state: StepState.complete,
                  ),
                  // Step(
                  //   title: new Text('Ready for Pickup'),
                  //   content: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: <Widget>[
                  //       DynamicFontSize(
                  //         label: "Order is ready for pickup",
                  //       ),
                  //       DynamicFontSize(
                  //         label: widget.oderModel.pickupDate ?? "",
                  //       ),
                  //     ],
                  //   ),
                  //   isActive: widget.oderModel.isComplete
                  //       ? true
                  //       : widget.oderModel.isReady,
                  //   state: StepState.complete,
                  // ),
                  if (!widget.oderModel.isCancelled!)
                    Step(
                      title: new Text('Order Complete'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          DynamicFontSize(
                            label: "Order Completed",
                          ),
                          DynamicFontSize(
                            label: widget.oderModel.completedDate!,
                          ),
                        ],
                      ),
                      isActive: widget.oderModel.isComplete!,
                      state: StepState.complete,
                    ),
                  if (widget.oderModel.isCancelled!)
                    Step(
                      title: new Text('Order Cancelled'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          DynamicFontSize(
                            label: "Order Cancelled",
                          ),
                          DynamicFontSize(
                            label: widget.oderModel.cancelledDate!,
                          ),
                        ],
                      ),
                      isActive: widget.oderModel.isCancelled!,
                      state: StepState.complete,
                    ),
                ],
              ),
            ),
            // if (widget.oderModel.isComplete)
            //   AppButton(
            //     text: "Kindly rate our product",
            //     isDark: true,
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => RatingView(widget.oderModel)));
            //     },
            //   ),
            VerticalSpace(40)
          ],
        ),
      ),
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
