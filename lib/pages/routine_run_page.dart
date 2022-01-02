import 'package:flutter/material.dart';
import 'package:hangbuddy/entities/repetition_routine.dart';

class RoutineRunPage extends StatefulWidget {
  const RoutineRunPage({Key? key, required this.routine}) : super(key: key);

  final RepetitionRoutine routine;

  @override
  _RoutineRunPageState createState() => _RoutineRunPageState();
}

class _RoutineRunPageState extends State<RoutineRunPage>
    with TickerProviderStateMixin {
  // Use -1 to indicate that we should display a "prepare" step
  int _currentStep = -1;

  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: _currentDuration()),
    )..addListener(() {
        setState(() {
          if (_controller.value == 1 && !_isLastStep()) {
            _incrementStep();
          }
        });
      });
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.routine.name),
          shadowColor: Colors.transparent,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCommandText(),
              _buildCountdown(),
              _buildNextStep()
            ],
          ),
        ));
  }

  Widget _buildCommandText() {
    return Row(children: [
      Expanded(
          child: Column(children: [
        Text(
          _currentStepName(),
          style: Theme.of(context).textTheme.headline2,
        ),
        Text(
            "${_currentRepetition().toString()} / ${widget.routine.repetitions}",
            style: Theme.of(context).textTheme.bodyText2)
      ]))
    ]);
  }

  Widget _buildCountdown() {
    var timeLeft =
        ((1 - _controller.value) * _currentDuration()).ceil().toString();
    return SizedBox(
      height: 200,
      width: 200,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: _controller.value,
            semanticsLabel: 'Hang / Wait routine',
            color: Theme.of(context).colorScheme.onPrimary,
            strokeWidth: 40,
          ),
          Center(
              child:
                  Text(timeLeft, style: Theme.of(context).textTheme.headline1))
        ],
      ),
    );
  }

  Widget _buildNextStep() {
    return Row(
      children: [
        Expanded(
            child: Text("Next: ${_nextStepLabel()}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5))
      ],
    );
  }

  int _currentDuration() {
    if (_currentStep == -1) {
      return 10;
    } else if (_currentStep % 2 == 0) {
      return widget.routine.hangTime;
    } else {
      return widget.routine.restTime;
    }
  }

  int? _nextDuration() {
    if (_isLastStep()) {
      return null;
    }

    if (_currentStep % 2 == 1) {
      return widget.routine.hangTime;
    }

    return widget.routine.restTime;
  }

  int _currentRepetition() {
    if (_currentStep == -1) {
      return 0;
    }

    return (_currentStep ~/ 2) + 1;
  }

  String _currentStepName() {
    if (_currentStep == -1) {
      return 'PREPARE';
    }

    if (_currentStep % 2 == 0) {
      return 'HANG';
    }

    return 'REST';
  }

  String _nextStepName() {
    if (_currentStep % 2 == 1) {
      return 'HANG';
    }

    if (_isLastStep()) {
      return 'FINISH';
    }

    return 'REST';
  }

  String _nextStepLabel() {
    if (_isLastStep()) {
      return 'FINISHED';
    }
    return "${_nextStepName()} ${_nextDuration()}s";
  }

  void _incrementStep() {
    _currentStep++;
    _controller.reset();
    _controller.duration = Duration(seconds: _currentDuration());
    _controller.forward();
  }

  bool _isLastStep() {
    return _currentStep == ((widget.routine.repetitions * 2) - 1);
  }
}
