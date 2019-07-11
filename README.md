# TsmPluginFramework - Plugin Framework for TransModeler Traffic Simulator

TsmPluginFramework enables development of TransModeler plugins with integrated scripted GUI, parameter configurations, and user's core business logic - all in a unified workflow.

TsmPluginFramework wrapps up TransModeler's raw TsmApi COM interfaces, Parameter Editor interface, Vehicle Monitor APIs, and Gisdk scripting into a high-level appliaction framework. 

Caliper Gisdk script compiler is embedded in the framework as Just-in-Time (JIT) compiling engine. This allows genreating native looking user interfaces consistent with TransModeler's own UI theme.

Source Code
--------------
Source codes are written in RemObject Oxygene (Object Pascal) and C/C++.  Oxygene's native Win32 LLVM-based compiler generates highly optimized performant machine code, rendering the plugins computationally efficient during simulation run time.

TsmPluginFramework does not limit the choice of programming language to Object Pascal.  Swift, C# or Java can be used to develop TransModeler plugins using TsmPluginFramework, thanks to RemObject's compilers that alow programming these languages interchangably.

About TransModeler
--------------
TransModeler® is registered trademark of Caliper Corporation. It is probably the fastest traffic simulator on Windows Win32 platform, due to its highly optimized underlying infrastructure. It features full-fledged powerful GIS capabilites, extremely detailed modelling realism (visually, and modelling wise),  and flexible plugin mechnism not available from other traffic simulators on the market. 

A TransModeler license is required in order to use the plugin framework presented herein. For more information about TransModeler visit https://www.caliper.com/transmodeler/default.htm


About RemObject Oxygene
-------------
RemObject Oxygene compiler can be obtained from https://www.elementscompiler.com/elements/default.aspx



Developed by Wuping Xin, and Copyright KLD © 2019

