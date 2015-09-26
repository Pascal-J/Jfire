cocurrent 'z'
pD_z_ =: 1!:2&2
cders_z_ =: cder ; cderx
coself_z_ =: coname@(''"_)
codestroy =: (coerase@coname@(''"_) ] destroy :: ])"0
coinsert=: 3 : 0  NB. change to allow insert of an object rather than class.  boxopen instead of <
 n=. ;: :: ] y
 p=. ; (, 18!:2) @ boxopen each n
 p=. ~. ( 18!:2 coname''), p
 (p /: p = <,'z') 18!:2 coname''
)
inl_z_ =: (cocurrent@] ".@] [)"1 0
inlC_z_ =: 2 : 0 
 (([: <^:(0=L.) v"_) inl~ m , ' ', lr@:]) :  (([: <^:(0=L.) v"_) inl~ (lr@:[), ' ' ,m , ' ', lr@:] )
)
cocurrent2 =: 18!:4@boxxopen ] coname@(''"_)
inlA_z_ =: 1 : 'u inlC  (18!:5 '''')'
coassign_z_ =: 4 : 0 NB.y is object or list of objects. x is string name.  Destroys previous value prior to assign.
 try. (coerase  ] 'destroy a:'&inl :: ]) x~ catch. end.
 (x) =: y
)
lr_z_ =: 3 : '5!:5 < ''y'''
lrA_z_ =: 1 : '5!:5 < ''u'''
loc =: (,&'_'@[ ,&'_'@, ":@>@])"1 0
locs =: 1 : 'm loc 18!:5 '''''
eval_z_ =: 1 : ' a: 1 :  m'
reduce =: 1 : '<"_1@[ ([: u &.>/(>@:) ,) <@:]'
assign_z_ =: 4 : '(x) =: y'
dlt0 =: #~ ([: (+./\ *. +./\.) (0{a.)&~:)
dltb0 =: dlt0@:dltb
NoteB =: Note : (] [ Note@]) f.