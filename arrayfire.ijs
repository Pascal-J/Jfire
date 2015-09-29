
require 'dll'
cocurrent 'af'
NB.pD 'Arrayfire libpath set to: ' ;libAFpath =: IFWIN pick '';'D:\Program Files\ArrayFire\v3\lib' NB. OVERWRITTEN NEXT LINE
libAFpath =: libAFpathset_af_  NB. set in loader
libAFmainlib =: libAFpath , (IFIOS + (;: 'Win Linux Android Darwin') i. <UNAME_z_) pick '\afcpu.dll'; ('libafcpu.so';'/system/lib/libafcpu.so'),  (2 $ <'/usr/lib/afcpu.dylib ')
libAFmainlib =:  ('"', ],'"'"_)^:(IFWIN"_) libAFmainlib 
libAF =: 1 : '(libAFmainlib , '' '' , m)&cd'
cocurrent 'afhelper'
chkerr =: ({. , <@cders@(''"_) ; ])`(1 {.@{:: ])@.(0 = 0 {:: ])
chkerR =: (3 : 'pD ({. , <@cders@(''''"_) ; ]) y label_. [:')`(1 {.@{:: ])@.(0 = 0 {:: ])
cocurrent 'af'
coinsert 'afhelper'
coinsert 'afenums'
cdparseC =: 4 : 'if. ''>'' = {.x do. (y) =: (y , '' > + ''  , }. x) libAF else. (y) =: (y , '' + ''  , x) libAF end. y'&>/"1
cdparse =:cdparseS =: 4 : '(y) =: (y , '' '' , x) libAF label_. y'&>/"1
BUGGY =: dltb leaf ((':' {.@:cut [), {.@:('('&cut)@])&>/"1 ] 2 {."1 (9{a.) cut every cutLF 0 : 0
n *c *c *c *c :  void 	deviceInfo(char *d_name, char *d_platform, char *d_toolkit, char *d_compute)
i *c *c *c *c : af_err 	af_deviceprop(char* d_name, char* d_platform, char *d_toolkit, char* d_compute)
l n : AFAPI int 	getDeviceCount()
)
AFLIB =: dltb leaf ((':' {.@:cut [), {.@:('('&cut)@])&>/"1 ] 2 {."1 (9{a.) cut every cutLF 0 : 0
i *c *c *c *c : af_err 	af_device_info(char* d_name, char* d_platform, char *d_toolkit, char* d_compute)
i *i : af_err 		af_get_device_count(	int * 	num_of_devices	)	
i c : AFAPI af_err		af_info()
i n : AFAPI af_err		af_init()
i i : af_err 		af_sync(const int device)
i *i : af_err		af_free_device(void *ptr)
i i : af_err 		af_set_device(	const int 	device	)
i *i : af_err		af_get_device(	int * 	device	)	
i *i i :af_err 		af_get_dbl_support (bool *available, const int device)
i *i *i *i *i :af_err 	af_device_mem_info (size_t *alloc_bytes, size_t *alloc_buffers, size_t *lock_bytes, size_t *lock_buffers)
i n :af_err 		af_device_gc ()
i i :af_err 		af_set_backend(const af_backend bknd)
i *i *i *i *i :af_err	af_device_mem_info (size_t *alloc_bytes, size_t *alloc_buffers, size_t *lock_bytes, size_t *lock_buffers)
i *i :af_err 		af_get_mem_step_size(size_t * 	step_bytes	)	
i *x *x x *x i :af_err 	af_create_array (af_array *arr, const void *const data, const unsigned ndims, const dim_t *const dims, const af_dtype type)
i *x x:af_err 		af_get_data_ptr (void *data, const af_array arr)
> i x :af_err 		af_release_array (af_array arr)
i *x x:af_err		af_retain_array (af_array *out, const af_array in)
i *i x :af_err 		af_get_numdims (unsigned *result, const af_array arr)
i *i *i *i *i x:af_err	af_get_dims(dim_t * d0,dim_t * d1,dim_t * d2,dim_t * d3,const af_array arr 
i *i x:af_err 		af_get_type (af_dtype *type, const af_array arr)
i *i x:af_err 		af_get_elements (dim_t *elems, const af_array arr)
i *x x x i:af_err 		af_add (af_array *out, const af_array lhs, const af_array rhs, const bool batch)
i *x x x i:af_err 		af_sub (af_array *out, const af_array lhs, const af_array rhs, const bool batch)
i *x x x i:af_err 		af_mul (af_array *out, const af_array lhs, const af_array rhs, const bool batch)
i *x x x i:af_err 		af_div (af_array *out, const af_array lhs, const af_array rhs, const bool batch)
i *x x x i:af_err 		af_bitxor (af_array *out, const af_array lhs, const af_array rhs, const bool batch)
i *x x x i:af_err 		af_bitand (af_array *out, const af_array lhs, const af_array rhs, const bool batch)
i *x x x i:af_err 		af_bitor (af_array *out, const af_array lhs, const af_array rhs, const bool batch)
i *x x x i:af_err 		af_mod (af_array *out, const af_array lhs, const af_array rhs, const bool batch)
i *x x x i:af_err 		af_exp (af_array *out, const af_array lhs, const af_array rhs, const bool batch)
i *x x x i i:af_err 	af_matmul (af_array *out, const af_array lhs, const af_array rhs, const af_mat_prop optLhs, const af_mat_prop optRhs)
i *x x i:af_err 		af_set_unique (af_array *out, const af_array in, const bool is_sorted)
i *x x x i:af_err 		af_set_intersect (af_array *out, const af_array first, const af_array second, const bool is_unique)
i *x x x i:af_err 		af_set_union (af_array *out, const af_array first, const af_array second, const bool is_unique)
i *x x i :af_err 		af_sum (af_array *out, const af_array in, const int dim)
i *x x i :af_err 		af_product (af_array *out, const af_array in, const int dim)
i *x x i :af_err 		af_min (af_array *out, const af_array in, const int dim)
i *x x i :af_err 		af_max (af_array *out, const af_array in, const int dim)
i *x x i :af_err 		af_alltrue (af_array *out, const af_array in, const int dim)
i *x x i :af_err 		af_anytrue (af_array *out, const af_array in, const int dim)
i *x x i :af_err 		af_count (af_array *out, const af_array in, const int dim)
)
cdSp =: 3 : '''c n s'' =. y label_.(n,s) =: (n , '' '' , c) libAF label_. y'"1
SPECIALVERs =: dltb leaf ((':' {.@:cut 1 {:: ]) , {.@:('('&cut)@(2 {:: ]) ,{.)"1 ] 3 {."1 (9{a.) cut every cutLF 0 : 0
F	i *x *f x *x i :af_err 	af_create_array (af_array *arr, const void *const data, const unsigned ndims, const dim_t *const dims, const af_dtype type)
J	i *x *j x *x i :af_err 	af_create_array (af_array *arr, const void *const data, const unsigned ndims, const dim_t *const dims, const af_dtype type)
D	i *x *d x *x i :af_err 	af_create_array (af_array *arr, const void *const data, const unsigned ndims, const dim_t *const dims, const af_dtype type)
S	i *x *i x *x i :af_err 	af_create_array (af_array *arr, const void *const data, const unsigned ndims, const dim_t *const dims, const af_dtype type)
F	i *f x:af_err 		af_get_data_ptr (void *data, const af_array arr)
D	i *d x:af_err 		af_get_data_ptr (void *data, const af_array arr)
S	i *i x:af_err 		af_get_data_ptr (void *data, const af_array arr)
)
get_device_count =: (1 {.@{:: af_get_device_count@<@,@0:) :: 0:
get_device =: 1 {.@{:: af_get_device@<@,@0:
set_device =: 3 : 'CURRENT =: get_device@:af_set_device y' NB. y is int ID.  No error if return = y
set_device =: 3 : '1 {:: af_set_device NUMDEVICES | y ' NB. don't cache current, but allow perpetual toggle of devices by rolling over out of bounds.
device_mem_info =:  (' DoubleSupport?: ' , ":@:get_dbl_support@:get_device) ;  [: }.@af_device_mem_info  ,@1:;,@2:;,@3:;,@4:
mem_infoF =: ({. , (cut 'AlocByte: AlocBuf: LockByte: LockBuf:') (, ' ' , ":) each }.)@:device_mem_info
device_info =: [: dltb0 each  (DRIVER  ,' DeviceID : ' , ":@get_device) ; [: }.@af_device_info  (128 <@$ ' '"_) ,(128 <@$ ' '"_) ,(128 <@$ ' '"_) , 128 <@$ ' '"_
infoF =: device_info ,: mem_infoF
get_dbl_support =: 1 {:: [: af_get_dbl_support (,0);]
info =: af_info@:(' '"_)  NB. console only.  device_info much more useful anyway.
device_gc=: af_device_gc@:(' '"_)
A =: ([: (af_create_array)  (,0) ; , ; (1 >. #@$) ; ,@$`(,@1:)@.((i.0) -: $) ; MAPa ) 
A =: ([: (chkerR@af_create_array)  (,0) ; , ; (1 >. #@$) ; (4 {.!.1 $) ; s64"_ )
Ad=: ([: (chkerR@af_create_arrayD)  (,0) ; , ; (1 >. #@$) ; (4 {.!.1 $) ; f64"_ ) 
Af=: ([: (chkerR@af_create_arrayF)  (,0) ; , ; (1 >. #@$) ; (4 {.!.1 $) ; f32"_ )
As=: ([: (chkerR@af_create_arrayS)  (,0) ; , ; (1 >. #@$) ; (4 {.!.1 $) ; s32"_ )
'useless' NB.create_arrayRshape =: [: (af_create_array)  (,0) ; ,@] ;(1 >. 0 #@{:: [ ) ; [  NB. Dyad x is manual  shape and datatype.  manual shape may be needed due to dll unpacking of items.
Atyped =: [: (chkerR@af_create_array)  (,0) ; ,@] ;(1 >. #@$)@];(4 {.!.1 $)@] ; [   NB. Dyad x is manual datatype.  
Atypedf =: [: (chkerR@af_create_arrayF)  (,0) ; ,@] ;(1 >. #@$)@];(4 {.!.1 $)@] ; [   NB. Dyad x is manual datatype.  

R =: af_release_array"0
get_dims =: [: {.every 1 2 3 4 { [: af_get_dims (, each 0 1 2 3)(,<)]
get_numdims =: 1 {.@{:: [: af_get_numdims (,0) ; ]
get_type =: 1 {.@{:: [: af_get_type (,0) ; ]
dims =:  get_numdims{. get_dims
count =: {.@get_dims
num_elements =: 1 {.@{::[: af_get_elements (,0);]

J =: (dims $ 1 {:: [: (af_get_data_ptrF)`('c32 not supported' assert 0:)`(af_get_data_ptrD)`(af_get_data_ptrJ)`(af_get_data_ptrB)`(af_get_data_ptrS)`(af_get_data_ptr)`(af_get_data_ptrB)`(af_get_data_ptr)`(af_get_data_ptr)@.(1 get_type@{:: ]) (num_elements # AFpadval@get_type) ; ])"0
'not safe enough' NB. assignR =: assign [ R@(4 :'x~ assert. 100000000 < | x~' :: 0:) NB. Release ptr in name(str) x , then assign y to x
NB. not complete but good idea.  managed mem much more useful though.
Ra =: 2 : 0 NB. applies verb u, and releases args indicated by list n: 0 no release. negative: index of 1based-x param positive: 1based-index of y param. Ex: xptr add Ra (_1 1) yptr releases both x and y after getting result of add
([ 'R'locs@[ v"_ <:@ #~ 0 > v"_) ] (] 'R'locs@[ v"_ <:@ #~ 0 < v"_) ]u 
)
JR =: (R ] J)"0  NB. release after getting toJ
add =: ([: chkerR@af_add (,0) ; [ ; ] ; 0:)"0 0  NB. overwritten by next batch.
NB.add =: ([: chkerR@af_bitxor (,0) ; [ ; ] ; 1:)"0 0
dyadlist =: 'add bitxor bitand bitor sub mul div mod exp'
3 : '(y) =: (''([: chkerR@af_'', y, '' (,0) ; [ ; ] ; 1:)"0 0'' ) eval label_. y' each ;: dyadlist 
reducelist =: 'sum product count alltrue anytrue max min'
3 : '(y) =: (''(_1&$: : ([: chkerR@af_'', y, '' (,0) ; [ ;~ ]))"0 _ 0'' ) eval label_. y' each ;: reducelist 
add_a =: ([: chkerR@af_add (0 {:: ]) ; 1&{:: ; 2&{:: ; 0:)"1 NB. monad triplet version. result, x, y pointers. 0 for result creates new array. FAILS (but keep trying): Hopefully can overwrite result into existing array pointer.
matmul =: 1 : 'a=. coname '''' label_. ([: chkerR__a@af_matmul__a f. (,0) ; [ ; (;/m) ;~ ])' NB. m is transpose options 0 0 is no transpose.  see enumbs below
set =: 0&$: : ([: chkerR@af_set_unique (,0) ; [ ;~ ])
set_intersect =: 1 : 'a=. coname '''' label_. ([: chkerR__a@af_set_intersect__a f. (,0) ; [ ; (m) ;~ ])'
set_union =: 1 : 'a=. coname '''' label_. ([: chkerR__a@af_set_union__a f. (,0) ; [ ; (m) ;~ ])'

cocurrent 'afenums'
enumO =: (] assign each  i.@#)
enum =: ([ assign ".@])&>/"1
enumO ' '{.@cut every ',' {.@cut"1 dltb every cutLF 0 : 0
   f32,    ///< 32-bit floating point values
    c32,    ///< 32-bit complex floating point values
    f64,    ///< 64-bit complex floating point values
    c64,    ///< 64-bit complex floating point values
    b8,     ///< 8-bit boolean values
    s32,    ///< 32-bit signed integral values
    u32,    ///< 32-bit unsigned integral values
    u8,     ///< 8-bit unsigned integral values
    s64,    ///< 64-bit signed integral values
    u64     ///< 64-bit unsigned integral values
)
MAPa =: (4 7 ,(IF64 { 5 8 ) ,(IF64 { 0 2 ),(IF64 { 1 3)  ){~ 1 2 4 8 16 i. 3!:0  NB. mapArr
MAPs =: 3 : 0@:MAPa  NB. input is an above enum.   mapSafe
 if. -.get_dbl_support CURRENT do. 2 -~^:(2 3 e. ]) y else. y end.
)
AFbytesize =: {&4 4 8 1 4 4 1 8 8
AFmemrsize =: {&8 16 8 16 2 4 4 2 4 4
AFpadval =: {::&(0.5;0j1;0.5;0j1;0;0;0;0;0) :: 0:  NB.errors can still get data out.
AFpadval =: {::&(0.5;0j1;0.5;0j1;0;0;0;0;0) :: (0.5"_)

enum  dltb each"1 '=' cut every ',' {.@cut"1 dltb every cutLF  0 : 0
   AF_BACKEND_DEFAULT = 0,  ///< Default backend order: OpenCL -> CUDA -> CPU
    AF_BACKEND_CPU     = 1,  ///< CPU a.k.a sequential algorithms
    AF_BACKEND_CUDA    = 2,  ///< CUDA Compute Backend
    AF_BACKEND_OPENCL  = 3,  ///< OpenCL Compute Backend
)

enum  dltb each"1 '=' cut every ',' {.@cut"1 dltb every cutLF  0 : 0
    AF_ERR_NO_MEM         = 101,    /// The system or device ran out of memory  100-199 Errors in environment
    AF_ERR_DRIVER         = 102,    /// There was an error in the device driver
    AF_ERR_RUNTIME        = 103,    /// There was an error with the runtime environment
    AF_ERR_INVALID_ARRAY  = 201,    /// The input array is not a valid af_array object.200-299 Errors in input parameters
    AF_ERR_ARG            = 202,  /// One of the function arguments is incorrect
    AF_ERR_SIZE           = 203,  /// The size is incorrect
    AF_ERR_TYPE           = 204,  /// The type is not suppported by this function
    AF_ERR_DIFF_TYPE      = 205,  /// The type of the input arrays are not compatible
    AF_ERR_BATCH          = 207,   /// Function does not support GFOR / batch mode
    AF_ERR_NOT_SUPPORTED  = 301,   /// The option is not supported 300-399 Errors for missing software features
    AF_ERR_NOT_CONFIGURED = 302,   /// This build of ArrayFire does not support this feature
    AFF_ERR_NONFREE       = 303,   /// This build of ArrayFire is not compiled with "nonfree" algorithms
    AF_ERR_NO_DBL         = 401,    /// This device does not support double 400-499 Errors for missing hardware features
    AF_ERR_NO_GFX         = 402,   /// This build of ArrayFire was not built with graphics or this device does not support graphics
    AF_ERR_LOAD_LIB       = 501,  // 500-599 Errors specific to heterogenous API
    AF_ERR_LOAD_SYM       = 502,   // 900-999 Errors from upstream libraries and runtimes
    AF_ERR_INTERNAL       = 998,   /// There was an internal error either in ArrayFire or in a project upstream
    AF_ERR_UNKNOWN        = 999,      /// Unknown Error
)

enum  dltb each"1 '=' cut every ',' {.@cut"1 dltb every cutLF  0 : 0
    AF_MAT_NONE       = 0,    ///< Default
    AF_MAT_TRANS      = 1,    ///< Data needs to be transposed
    AF_MAT_CTRANS     = 2,    ///< Data needs to be conjugate tansposed
    AF_MAT_CONJ       = 4,    ///< Data needs to be conjugate
    AF_MAT_UPPER      = 32,   ///< Matrix is upper triangular
    AF_MAT_LOWER      = 64,   ///< Matrix is lower triangular
    AF_MAT_DIAG_UNIT  = 128,  ///< Matrix diagonal contains unitary values
    AF_MAT_SYM        = 512,  ///< Matrix is symmetric
    AF_MAT_POSDEF     = 1024, ///< Matrix is positive definite
    AF_MAT_ORTHOG     = 2048, ///< Matrix is orthogonal
    AF_MAT_TRI_DIAG   = 4096, ///< Matrix is tri diagonal
    AF_MAT_BLOCK_DIAG = 8192,  ///< Matrix is block diagonal
)

(cutLF 0 : 0) inl each"2 0  <"0@boxopen LIBFILTER_af_ # ;: 'afcpu afcuda afopencl'
a =. > coname ''
coinsert 'af'
DRIVER =: (('''', toupper  a ,'''') , '"_') eval
libAFmainlib =: libAFpath , (IFIOS + (;: 'Win Linux Android Darwin') i. <UNAME_z_) pick ('\', a ,'.dll'); (('lib',a,'.so');'/system/lib/',a ,'.so'),  (2 $ <'/usr/lib/',a,'.dylib ')
libAFmainlib =:  ('"', ],'"'"_)^:(IFWIN"_) libAFmainlib 
cdparse f. AFLIB
cdSp f. SPECIALVERs
intersect =: 0 set_intersect
union =: 0 set_union
NUMDEVICES =: get_device_count 0
)
NB. coclass 'afcpu'
NB.
NB. coinsert 'af'
NB. DRIVER =: 'AF-CPU'"_
NB. libAFmainlib =: libAFpath , (IFIOS + (;: 'Win Linux Android Darwin') i. <UNAME_z_) pick '\afcpu.dll'; ('libafcpu.so';'/system/lib/afcpu.so'),  (2 $ <'/usr/lib/afcpu.dylib ')
NB. libAFmainlib =:  ('"', ],'"'"_)^:(IFWIN"_) libAFmainlib 
NB. cdparse f. AFLIB
NB. cdSp f. SPECIALVERs
NB. NUMDEVICES =: get_device_count 0
NB.
NB. coclass 'afopencl'
NB. coinsert 'af'
NB. DRIVER =: 'AF-OPENCL'"_
NB. libAFmainlib =: libAFpath , (IFIOS + (;: 'Win Linux Android Darwin') i. <UNAME_z_) pick '\afopencl.dll'; ('libafopencl.so';'/system/lib/afopencl.so'),  (2 $ <'/usr/lib/afopencl.dylib ')
NB. libAFmainlib =:  ('"', ],'"'"_)^:(IFWIN"_) libAFmainlib 
NB. cdparse f. AFLIB
NB. cdSp f. SPECIALVERs
NB. NUMDEVICES =: get_device_count 0
NB.
NB. coclass 'afcuda'
NB. coinsert 'af'
NB. DRIVER =: 'AF-CUDA'"_
NB. libAFmainlib =: libAFpath , (IFIOS + (;: 'Win Linux Android Darwin') i. <UNAME_z_) pick '\libafcuda.dll'; ('libafcuda.so';'/system/lib/libafcuda.so'),  (2 $ <'/usr/lib/libafcuda.dylib ')
NB. libAFmainlib =:  ('"', ],'"'"_)^:(IFWIN"_) libAFmainlib 
NB. cdparse f. AFLIB
NB. cdSp f. SPECIALVERs
NB. NUMDEVICES =: get_device_count 0


NB. shaddow functions for J implementation.
coclass 'afJ'
coinsert 'afhelper'
add =: +
sub =: 0&- : -
mod =: |~
A =: Ad =: Af =: J =:]
NB. etc.

coclass 'afdevice' ( [ [ Note@]) 'Devices with mem manager'
 Pattern attempt to access devices independently of dll/locales that cover their functions.
 create param is locale (afcpu;afcude;afopencl or compatible) and optionally a device to lock/switch to TOHANDLE
 if you do not wish to use multiple devices from one library, then just pass locale.
 adds managed memory interface.  Multiple objects share one resource, but application is to batch clear memory pointers.
)
MANAGED =: i.0
create =: 3 : 0
 coinsert  {. boxopen y
 MyDid =: 1 {:: y
 if. 2=#boxopen y do. setme =: ('] [ set_device@', ':',~ ": MyDid) eval end.  NB. setme only necessary call if multidevice
 setme a:
)
info =: 3 : 'infoF MyDid'
(<' appendmanaged@:') 4 : '(y,''M'') =: ( x, (,y)  ) eval label_. y' each ;: 'A Ad Af As set intersect union' , dyadlist_af_ , ' ' , , reducelist_af_
NB. (< 'appendmanaged') 4 : 0 each ;: 'matmul'
NB.  (y,'M') =: (' u ' , (quote y) , ' locs ' , (quote x) , ' locs@) ' ) (1 : )  label_. y
NB. )
'adverbs are hard' NB.matmulM =: 1 : 'a=. coname '''' label_. u matmul__a (appendmanaged__a@)'
appendmanaged =: 3 : 'y[ MANAGED =: MANAGED , , y'
clearmanaged =: 3 : 'MANAGED =: y [ R"0 MANAGED'
killmanaged =: ] [ clearmanaged @: ((i.0)"_)
destroy =: killmanaged NB.device_gc@:killmanaged  NB. gc misdoc'd