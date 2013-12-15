import 'package:polymer/polymer.dart';
import 'dart:html';

@CustomTag('shoot-button')
class ShootButton extends ButtonElement with Polymer, Observable {
  ShootButton.created() : super.created() {
    polymerCreated();
  }
}