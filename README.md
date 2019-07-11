# TsmPluginFramework - Plugin framework for TransModeler traffic simulator. 

TsmPluginFramework enables development of TransModeler plugins with integrated scripted GUI, parameter configurations, and user's core business logic - all in a unified workflow.

TsmPluginFramework wrapps up TransModeler's raw TsmApi COM interfaces, Parameter Editor interface, Vehicle Monitor APIs, and Gisdk scripting into a high-level appliaction framework. 

Source codes are written in RemObject Oxygene (Object Pascal) and C/C++.  Oxygene's native Win32 LLVM-based compiler generates highly optimized performant machine code, rendering the plugins computationally efficient during simulation run time.

Caliper Gisdk script compiler is embedded in the framework as Just-in-Time (JIT) compiling engine. This allows genreating native looking user interfaces consistent with TransModeler's own UI theme.

TransModeler® is registered trademark of Caliper Corporation. A TransModeler license is required in order to use the plugin framework presented herein. For more information about TransModeler visit https://www.caliper.com/transmodeler/default.htm

RemObject Oxygene compiler can be obtained from https://www.elementscompiler.com/elements/default.aspx

Developed by Wuping Xin © 2019

