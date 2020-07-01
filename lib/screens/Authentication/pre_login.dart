import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:water_del/utilities/styles.dart';

class PreLogin extends StatefulWidget {
  @override
  _PreLoginState createState() => _PreLoginState();
}

class _PreLoginState extends State<PreLogin> {
  int currentStep = 0;
  bool complete = false;

  next() {
    setState(() {
      if (currentStep < steps.length - 1) {
        currentStep = currentStep + 1;
      } else {
        currentStep = 0;
      }
    });
  }

  cancel() {
    setState(() {
      if (currentStep > 0) {
        currentStep = currentStep - 1;
      } else {
        currentStep = 0;
      }
    });
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }

  List<Step> steps = [
    Step(
        title: Text(
          'My name is',
          style: normalOutlineBlack,
        ),
        isActive: true,
        state: StepState.editing,
        content: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Full Names(s)'),
              ),
            )
          ],
        )),
    Step(
        title: Text(
          'My phone number is',
          style: normalOutlineBlack,
        ),
        isActive: true,
        state: StepState.complete,
        content: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Phone'),
              ),
            )
          ],
        )),
    Step(
        title: Text(
          'Please deliver to',
          style: normalOutlineBlack,
        ),
        isActive: true,
        state: StepState.complete,
        content: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Address'),
              ),
            )
          ],
        ))
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Personalise your account',
          style: buttonWhite,
        ),
        centerTitle: true,
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            height: size.height,
            width: size.width,
            child: Column(
              children: <Widget>[
                Expanded(
                    child: Stepper(
                  steps: steps,
                  currentStep: currentStep,
                  onStepContinue: next,
                  onStepTapped: (value) => goTo(value),
                  onStepCancel: cancel(),
                  controlsBuilder: (context, {onStepContinue, onStepCancel}) =>
                      Row(
                    children: <Widget>[
                      FlatButton(
                          onPressed: onStepContinue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            'NEXT',
                            style: normalOutlineWhite,
                          )),
                      FlatButton(
                          onPressed: onStepCancel,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          color: Theme.of(context).accentColor,
                          child: Text(
                            'BACK',
                            style: normalOutlineWhite,
                          ))
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
