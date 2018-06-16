# Dependencies

Reducing dependencies means recognizing and removing the ones you don't need

An object has dependencies when it knows:
- the name of an other class
- The name of a message that it intens to send to someone other than self (knows
  the name of a method in an other class)
- the arguments that a message (mehtod) requires
- the order of those arguments

Other dependencies:
- an object knows another that knows something
- test on code that are to tightly coupled to the code

# Coding techiniques that reduce dependencies by decoupling code

## 1 - Inject dependencies
reducing dependencies by making sure that your methods don't know the name of
an other class. Pass in a object (any object) that responds to the message you want
to send. Deal with the object in the initialize. This way you can handle all sorts
objects that respond to that message
=> Know less, do more


## 2 - Isolate dependencies
If you can not remove dependencies (like maybe in exsisting code base):
isolate the dependencies in your class

### 2a - Isolate instance creation
If you can't change your code to inject the whole 'forgein' object into your class
(can't inject wheel into your gear), you should isolate the creation of the object
and explicitly expose the depenceny while reducing the reach into your class.

Option 1: create object in initialize (@wheel = Wheel.new(...))
Option 2: create object in seperate method (def wheel; @wheel ||= Wheel.new(...))

### 2b - Isolate vulnarable external methods
if the call to your external methods is buried in other code, isolate (wrap) the
call part in its own method. Let the rest of the code just call that method
instead off object.method
