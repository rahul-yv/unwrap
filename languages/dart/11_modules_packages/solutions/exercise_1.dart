import "../mypackage/helpers.dart";

String exampleUsage() => greet("World");

void main() {
  assert(exampleUsage() == "Hello, World!");
  print("ok");
}
