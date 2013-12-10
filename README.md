SPTransiOS
==========

An iOS Library to interact with the SPTrans API

Dependencies: AFNetworking

Usage:

Add the library to your project

Set your developer token via the #define token statement

Implement the delegate methods stated on the SPTManagerDelegate protocol

Instanciate the SPTManager and make requests directly



The SPTManager class returns to the delegates Cocoa objects that contain the data obtained from the SPTrans servers;
Requests are seriallized via the AFNetworking queue;

