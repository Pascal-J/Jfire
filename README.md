# Jfire
Arrayfire bindings for J language

requires download and install of Arrayfire.  Binary versions at: http://arrayfire.com/download/
https://github.com/arrayfire/arrayfire
http://www.arrayfire.com/docs/index.htm
All J files in project should be in the same folder as this file.  load jfire.ijs in the J language (jsoftware.com) ide.

Arrayfire is a paralel math library (focused mainly on floating point) that uses a single interface to other GPU and CPU math libraries.

jfire.ijs includes setup utilities.  
arrayf_tests.ijs includes samples and benchmarks.

A memory manager is included as well as a device interface, and enhancements to J to allow easier locale management.
The device interface allows independent device locales each with their own memory manager.
This allows not having to assign results and clear an entire group of pointers with one call, or by codestroy__device ''
The same memory manager approach as my BN library is used.  Mixed automatic and manual memory management is available.
The M suffix on verbs that create pointers create an automanaged result.

The design allows J single line productivity.  Unlike my openssl bindings these use J dyads naturally, but the result is always a new pointer.

see tests for usage.

Error management is currently set to just crash at point of failure and didsplay what error information is returned from arrayfire (standard error is not used much by them, but the error codes are in arrayfire.ijs file)

A subset of functions are implemented so far, but it should be straight forward to add the others as they have common signatures.

Main commands in every locale and device:

A creates an array. (scalars are arrays too) Af, Ad, As create "typed" arrays float double int32.  I haven't implemented complex or byte arrays yet.  
A is simple monad with any numeric noun (handle chars when I do byte, but there are few functions suited to chars in AF library)  
R releases an array.  
M suffix (AM AfM...) puts created array in managed memory.  addM  mulM adds result to managed memory.  
J is universal from arrayfire to J command (every type)  
JR releases pointer after getting its contents.  

see wiki for performing the same BLAS tests that come with arrayfire in J

https://github.com/Pascal-J/Jfire/wiki
