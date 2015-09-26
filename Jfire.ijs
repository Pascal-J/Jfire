
Note 'This is Jfire'
Author: Pascal J -GPL3 liccense.
requires download and install of Arrayfire.  Binary versions at: http://arrayfire.com/download/
https://github.com/arrayfire/arrayfire
http://www.arrayfire.com/docs/index.htm
All J files in project should be in the same folder as this file

BINDINGS for Arrayfire: crossplatform and crosslibrary API parallel gpu and cpu library.
Jfire is mixed J and Arrayfire syntax, where J is the glue and scripting around the heavy libraries.
Potential for a J dsl that allows as identical syntax as possible to those libraries.  But the most practical approach:
  Design in J, and start copying over parts that could benefit from lazy and parallel computing to Arrayfire.
  So far, arrayfire on low end GPU hardware anyway shows promise for floating point or other calculation where you want less precision that J delivers.
  Heavy operations (matrix mult) can benefit the most.
  Arrayfire's current design involves a JIT step that adds noticeable lag on my system the first time a function is ran.
  But subsequent runs are respectably fast.
)

Note 'Settings/loader'
This file will (eventually) run a gui setup.  Process is if file arrayfire.settings in this folder exist, then load those otherwise start setup.
for now,
SETTINGS FILE FORMAT: (lines separated by linefeed)
path to arrayfire libraries (without trailing/)
3 boolean values (1 0) that describe which libraries to use CPU CUDA OPENCL (recommend CPU and OPENCL.  If you do not have NVidia chip then set CUDA to 0)
Default device ID for each library. 0 0 0 is safest setting (as all libraries with a device include id 0)
)

cocurrent 'afloader'
sampleconfig =: 0 : 0
D:\Program Files\ArrayFire\v3\lib
1 0 1
0 0 1
)
MYDIR =: getpath_j_  '\/' rplc~ > (4!:4<'thisfile'){(4!:3)  thisfile=:'' NB. boilerplate to set the working directory
require MYDIR ,'afzutils.ijs'

AFpath_base_ =: configpath =: 3 : 0
libAFpathset_af_ =: y
LIBFILTER_af_ =: 1 1 1
load  MYDIR_afloader_ ,'arrayfire.ijs'
try.c =. get_device_count_afcpu_ 1 catch. 'path likely wrong.' return. end.
pD (<' Device count: ') (,~ ; 'get_device_count 1'&inl@boxopen@] )  every ;: 'afcpu afcuda afopencl'
pD r =.  'get_device_count 1'&inl@boxopen@] every ;: 'afcpu afcuda afopencl'
pD ,. 'device_info@set_device"0 i. get_device_count 1'&inl@boxopen each ;: 'afcpu afcuda afopencl'
pD 'recommended config line 3 settings: 1st item in each box above is device 0: 0 0 0 is always safe' 
pD 'recommended config line 2 settings: ' , ":  0 < r
pD 'example 3rd line (append boxed to this result): to use cpu device 0, cuda (if any) device 0, and opencl device 1 :  0 0 1'
pD 'to set config, call       AFsetconfig_base_@:(AFpath_base_ ":each@:(, <) 0 0 0"_) ''' , y , ''''
y ; 0 < r
)
config =: 3 : 0 
pD a =.  cutLF y
'3 boxed parameters needed' assert 3 = # a
'3 boxed parameters needed' assert 1 = L. a
libAFpathset_af_ =: 0 {:: a
LIBFILTER_af_ =: 1 ".@{:: a
LIBDEFAULT_af_ =: 2 ".@{:: a
load  MYDIR_afloader_ ,'arrayfire.ijs'
load  MYDIR_afloader_ ,'arrayfire.ijs' NB. double to make sure :P
)
AFsetconfig_base_ =: setconfig =: 3 : 0
'3 boxed parameters needed' assert 3 = # y
'3 boxed parameters needed' assert 1 = L. y
(LF joinstring y) fwrite MYDIR_afloader_ ,'arrayfire.settings'
config_afloader_ fread MYDIR_afloader_ , 'arrayfire.settings'
'config file written and library loaded'

)



GUARD =: config@fread`_1:@.(_1 -: fread) MYDIR , 'arrayfire.settings'
'config not set. Call AFpath_base_ path to where arrayfirelibraries (such as afcpu.dll or afcpu.so) are. read jfire.ijs for more help.' assert _1 -.@-: GUARD
pD 'AFpath_base_ pathstr  to change Arrayfire config'


NB. see arrayf_test.ijs for examples and usage