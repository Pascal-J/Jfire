 MYDIR =: getpath_j_  '\/' rplc~ > (4!:4<'thisfile'){(4!:3)  thisfile=:'' NB. boilerplate to set the working directory
require MYDIR , 'arrayfire.ijs'

lrX_z_ =: 1 : ('''('', u lrA , '') '' , lr y';':';'''('', (lr x) , '') ('' , u lrA , '') '' , lr y') 
tsfX_z_ =: 1 : 'u [ [: 1!:2&2@:timespacex u lrX'

Note 'library locales vs device objects'
The library locales are afcpu afcuda and afopencl.  They do not have managed (by J) memory.
device objects are shown in the next note, and do have managed memory.  The first few tests can use either library locales or device objects.

TO CALL EACH TEST,
pass a list of locales (boxed if more than 1, or if a device object)
the code runs once for each locale passed as argument.
)
test1 =: 'no test crashed' [ ( cutLF 0 : 0) (pD@inl [ pD@:('  ', ":)@[)each"2 0  <"0@boxopen
infoF 1
JsR As i. 10 10 
1 3 10 30 timespacex 'JsR a =. As i. 10 10 100'
1 3 10 30 timespacex 'JR a =. A i. 10 10 100'
)
floats =: 'no test crashed' [ ( cutLF 0 : 0) (pD@inl [ pD@:('  ', ":)@[)each"2 0  <"0@boxopen
R b_base_ [ pD 0j16": J b_base_ =. Af ". ": %: 3 3 $ 1 2 3 5 6 7 8 10 11  NB. truncated f32
R a_base_ [pD 0j16": J a_base_ =: Af %: 3 3 $ 1 2 3 5 6 7 8 10 11 NB. not truncated f32.  
0j16": JR Ad ". ": %: 3 3 $ 1 2 3 5 6 7 8 10 11  NB. truncated f64
0j16": JR Ad %: 3 3 $ 1 2 3 5 6 7 8 10 11 NB. crashes if device has no double support NB. f64 not truncated
0j16": %: 3 3 $ 1 2 3 5 6 7 8 10 11 NB. What J thinks it should get back
)

maybefails =: 'no test crashed' [ ( cutLF 0 : 0) (pD@inl [ pD@:('  ', ":)@[)each"2 0  <"0@boxopen
 0j16": JR   Ad %: 3 3 $ 1 2 3 5 6 7 8 10 11  NB. crashes if device has no double support

)

adds =: 'no test crashed' [ ( cutLF 0 : 0) (pD@inl [ pD@:('  ', ":)@[)each"2 0  <"0@boxopen
 R a,b [ pD@JR c_base_ =: add/ tsfX 'a b' =. A"1 i.2 5
 R a,b [ pD(JR  ; get_type)  add/ 'a b' =. pD A every  6 ; i. 5  NB. if batchmode 0 on add
)
NB. TESTS BELOW THIS MUST BE CALLED WITH A DEVICE OBJECT(s).
Note 'sample to makde device objects (copy and F8)'
 C =. P =. ('afcpu';0) conew 'afdevice'
 C =. G =. ('afopencl';1) conew 'afdevice'
 addsManaged P,G
)
addsManaged =: 'no test crashed' [ ( cutLF 0 : 0) (pD@inl [ pD@:('  ', ":)@[)each"2 0  <"0@boxopen
 C =. coname ''  NB. not necessary as code will run in each y locale
 J addM/tsfX AM"1 i.4 5 NB. mem managed arrays.  must use a device object. use killmanaged__object to clear all mem allocated.
 JR__C (AM__C 100000 ) add__C AM__C   239420398023948 1231 1234  NB. scalar + vector
 JR__C (AM__C  1 2 ) add__C AM__C 2 3 $ 239420398023948 1231 1234 NB. vector + table reasonable compatibility shape
 JR__C (AM__C 2 2 $ 1 2 3 4) add__C AM__C 2 2 3 $ 239420398023948 1231 1234  NB.  reasonable compatibility shape
)

matmuls =: 'no test crashed' [ ( cutLF 0 : 0) (pD@inl [ pD@:('  ', ":)@[)each"2 0  <"0@boxopen
J 0 0 matmul~tsfX AdM 5 5 $ i. 5
timespacex'J 0 0 matmul~tsfX AdM 100 100 $ i. 5' NB. double
timespacex' J@:((0 0 matmul~)tsfX) AfM 100 100 $ i. 5' NB. float
timespacex'+/ . *~ 100 100 $ i. 5'
((+/ . *)~ -: [: J@:(0 0 matmul~)tsfX AfM) 100 100 $ i. 5  NB. TEST MATCHED. timing includes getting back to J
0 0 matmul~tsfX AdM 100 100 $ i. 5  NB. don't access result should return fast

killmanaged i.0
)
fails =: 'no test crashed' [ ( cutLF 0 : 0) (pD@inl [ pD@:('  ', ":)@[)each"2 0  <"0@boxopen
 R a,b [  add/ 'a b' =. A every 6 ; i. 5  NB. if batchmode 0 on add NB. fixed.
)

convolveRNG =: (4294967295 (17 b.) {:@$ ((] ,@:({."0 1)~ -@-:@[ , -:@[) ,: ] {~ -:@[ + i.@[) +//. @: (+//. @:((2147483647 | */~)"1)))
NB. convolveRNG ^:(5) >: i.2 6
convolveRNGtest =: 'no test crashed' [ ( cutLF 0 : 0) (pD@inl [ pD@:('  ', ":)@[)each"2 0  <"0@boxopen
 m31 =: A 2147483647
 J mulM~"0 AM"1 >: i.2 6 NB. make 2 arrays and square each
  +//.@:J m31 modM"0 0~ mulM~"0 AM"1 100000 i.2 6  NB. mod is J-backwards
  J (AM 2) mulM"0 0 AM"1 i.2 6
  ([: AM"1 $ #"1 ,.)"1 >: i.2 6  NB. can call J__device on output pointers to combine arrays.
  +//.  +//."_1 J  m31 modM~"0 (AM"0 mulM"0 0 AM)"1 >: i.2 6 
   NB.J   ([: AM"1 $ #"1 ,.) mulM"0 0"1 0 AM@])"1 >: i.2 6 
 ((4294967295 (17 b.) {:@$ ((] ,@:({."0 1)~ -@-:@[ , -:@[) ,: ] {~ -:@[ + i.@[) [: +//.@:(+//."_1@:J)  m31 modM~"0 (AM"0 mulM"0 0 AM)"1))^:4 tsfX >: i.2 6 
 ((4294967295 (17 b.) {:@$ ((] ,@:({."0 1)~ -@-:@[ , -:@[) ,: ] {~ -:@[ + i.@[) [: +//.@:(+//."_1@:J)  m31 modM~"0 (AM"0 mulM"0 0 AM)"1))^:3 tsfX >: i.2 12 
 convolveRNG_base_^:4 tsfX >: i.2 6  NB.4 iterations fail match
 convolveRNG_base_^:3 tsfX >: i.2 12  NB.3 iterations match
)

polymult =: 'no test crashed' [ ( cutLF 0 : 0) (pD@inl [ pD@:('  ', ":)@[)each"2 0  <"0@boxopen
 a =. ? 100000000 $~ c [ b =.  ? 100000000 $~  c=.350
 +//. J a  (AM"0@[ mulM"0 0 tsfX AM@]) b
 +//. J a  (([: AM"1 $ #"1 ,.)@[ mulM"0 0 tsfX AM@]) b
 a  (([: AM"1 $ #"1 ,.)@[ mulM"0 0 tsfX AM@]) b  NB. no access to result or oblique sum
 a +//.@:(*/) tsfX b
 killmanaged 0
)