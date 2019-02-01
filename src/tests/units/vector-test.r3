Rebol [
	Title:   "Rebol vector test script"
	Author:  "Oldes"
	File: 	 %vector-test.r3
	Tabs:	 4
	Needs:   [%../quick-test-module.r3]
]

~~~start-file~~~ "VECTOR"

===start-group=== "VECTOR"

--test-- "issue/2346"
	;@@ https://github.com/rebol/rebol-issues/issues/2346
	--assert [] = to-block make vector! 0

--test-- "issue/1036"
	;@@ https://github.com/rebol/rebol-issues/issues/1036
	--assert 2 = index? load mold/all next make vector! [integer! 32 4 [1 2 3 4]]

--test-- "VECTOR can be initialized using a block with CHARs"
	;@@ https://github.com/rebol/rebol-issues/issues/2348
	--assert vector? v: make vector! [integer! 8 [#"^(00)" #"^(01)" #"^(02)" #"a" #"b"]]
	--assert  0 = v/1
	--assert 98 = v/5

	--assert vector? v: make vector! [integer! 16 [#"^(00)" #"^(01)" #"^(02)" #"a" #"b"]]
	--assert  0 = v/1
	--assert 98 = v/5

--test-- "Random shuffle of vector vs. block"
	;@@ https://github.com/rebol/rebol-issues/issues/947
	v1: make vector! [integer! 32 5 [1 2 3 4 5]]
	v2: random v1
	--assert same? v1 v2
	b1: [1 2 3 4 5]
	b2: random b1
	--assert same? b1 b2

--test-- "Some vector! formats are invalid"
	;@@ https://github.com/rebol/rebol-issues/issues/350
	--assert error? try [make vector! [- decimal! 32]]
	--assert error? try [make vector! [- integer! 32]]

--test-- "FIRST, LAST on vector"
	;@@ https://github.com/rebol/rebol-issues/issues/459
	v: make vector! [integer! 8 [1 2 3]]
	--assert 1 = first v
	--assert 3 = last v
	--assert 1 = v/1
	--assert 3 = v/3

--test-- "LOAD/MOLD on vector"
	--assert v = load mold/all v
	--assert v = do load mold v

--test-- "Conversion from VECTOR to BINARY"
	;@@ https://github.com/rebol/rebol-issues/issues/2347
	--assert #{0102} = to binary! make vector! [integer! 8 [1 2]]
	--assert #{01000200} = to binary! make vector! [integer! 16 [1 2]]
	--assert #{0100000002000000} = to binary! make vector! [integer! 32 [1 2]]
	--assert 1 = to integer! head reverse to binary! make vector! [integer! 64 [1]]
	--assert #{0000803F} = to binary! make vector! [decimal! 32 [1.0]]
	--assert 1.0 = to decimal! head reverse to binary! make vector! [decimal! 64 [1.0]]

--test-- "VECTOR can be initialized using binary data"
	;@@ https://github.com/rebol/rebol-issues/issues/1410
	--assert vector? v: make vector! [integer! 16 #{010002000300}]
	--assert 1 = v/1
	--assert 3 = v/3

	b: to binary! make vector! [decimal! 32 [1.0 -1.0]]
	v: make vector! compose [decimal! 32 (b)]
	--assert v/1 = 1.0
	--assert v/2 = -1.0
	--assert b = to binary! v

--test-- "Croping input specification when size and series is provided"
	--assert 2 = length? v: make vector! [integer! 16 2 [1 2 3 4]]
	--assert 2 = v/2
	--assert none? v/3
	--assert 1 = length? v: make vector! [integer! 16 1 #{01000200}]
	--assert none? v/2

--test-- "Extending input specification when size and series is provided"
	--assert 4 = length? v: make vector! [integer! 16 4 [1 2]]
	--assert 2 = v/2
	--assert 0 = v/4
	--assert none? v/5

--test-- "Vector created with specified index"
	--assert 2 = index? v: make vector! [integer! 16 [1 2] 2]
	--assert 2 = index? v: make vector! [integer! 16 #{01000200} 2]

--test-- "MOLD/flat on vector"
	;@@ https://github.com/rebol/rebol-issues/issues/2349
	--assert (mold/flat make vector! [integer! 8 12]) = {make vector! [integer! 8 12 [0 0 0 0 0 0 0 0 0 0 0 0]]}
	--assert (mold/all/flat make vector! [integer! 8 12]) = "#[vector! integer! 8 12 [0 0 0 0 0 0 0 0 0 0 0 0]]"
	--assert (mold make vector! [integer! 8  2]) = {make vector! [integer! 8 2 [0 0]]}
	--assert (mold make vector! [integer! 8 20]) = {make vector! [integer! 8 20 [
    0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0
]]}
	v: make vector! [integer! 8 20]
	--assert (mold reduce [
	1 2
	v
	3 4
]) = {[
    1 2 make vector! [integer! 8 20 [
        0 0 0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0 0 0
    ]]
    3 4
]}

--test-- "QUERY on vector"
	;@@ https://github.com/rebol/rebol-issues/issues/2352
	v: make vector! [unsigned integer! 16 2]
	o: query v
	--assert object? o
	--assert not o/signed
	--assert o/type = 'integer!
	--assert o/size = 16
	--assert o/length = 2
--test-- "QUERY/MODE on vector"
	--assert [signed type size length] = query/mode v none
	--assert [16 integer!] = query/mode v [size type]
	--assert block? b: query/mode v [signed: length:]
	--assert all [not b/signed b/length = 2]
	--assert 16 = query/mode v 'size
	--assert 16 = size? v
--test-- "REFLECT on vector"
	--assert 16 = reflect v 'size
	--assert  2 = reflect v 'length
	--assert 'integer! = reflect v 'type
	--assert false = reflect v 'signed
	--assert [unsigned integer! 16 2] = reflect v 'spec
	--assert [unsigned integer! 16 2] = spec-of v
--test-- "ACCESSORS on vector"
	--assert 16 = v/size
	--assert  2 = v/length
	--assert 'integer! = v/type
	--assert false     = v/signed


===end-group===


===start-group=== "VECTOR math"

--test-- "VECTOR 8bit integer add/subtract"
	v: make vector! [unsigned integer! 8 [1 2 3 4]]
	--assert (v + 200) = make vector! [unsigned integer! 8 [201 202 203 204]]
	; the values are truncated on overflow:
	--assert (v + 200) = make vector! [unsigned integer! 8 [145 146 147 148]]
	--assert (v - 400) = make vector! [unsigned integer! 8 [1 2 3 4]]
	subtract (add v 10) 10
	--assert v = make vector! [unsigned integer! 8 [1 2 3 4]]
	1 + v
	--assert v = make vector! [unsigned integer! 8 [2 3 4 5]]
	-1.0 + v
	--assert v = make vector! [unsigned integer! 8 [1 2 3 4]]

	v: make vector! [integer! 8 [1 2 3 4]]
	--assert (v + 125) = make vector! [integer! 8 [126 127 -128 -127]]
	--assert (v - 125) = make vector! [integer! 8 [1 2 3 4]]

--test-- "VECTOR 8bit integer multiply"
	v: make vector! [unsigned integer! 8 [1 2 3 4]]
	--assert (v * 4) = make vector! [unsigned integer! 8 [4 8 12 16]]
	; the values are truncated on overflow:
	--assert (v * 20) = make vector! [unsigned integer! 8 [80 160 240 64]] ;64 = (16 * 20) - 256

	v: make vector! [integer! 8 [1 2 3 4]]
	--assert (v * 2.0) = make vector! [integer! 8 [2 4 6 8]]
	; the decimal is first converted to integer (2):
	--assert (v * 2.4) = make vector! [integer! 8 [4 8 12 16]]
	subtract (add v 10) 10
	--assert v = make vector! [integer! 8 [4 8 12 16]]

--test-- "VECTOR 16bit integer multiply"
	v: make vector! [unsigned integer! 16 [1 2 3 4]]
	--assert (v * 4) = make vector! [unsigned integer! 16 [4 8 12 16]]
	--assert (v * 20) = make vector! [unsigned integer! 16 [80 160 240 320]]
	multiply v 2
	--assert v = make vector! [unsigned integer! 16 [160 320 480 640]]

	v: make vector! [unsigned integer! 16 [1 2 3 4]]
	--assert (10   * copy v) = make vector! [unsigned integer! 16 [10 20 30 40]]
	--assert (10.0 * copy v) = make vector! [unsigned integer! 16 [10 20 30 40]]

	; the values are truncated on overflow:
	v: make vector! [unsigned integer! 16 [1 2 3 4]]
	--assert (v * 10000) = make vector! [unsigned integer! 16 [10000 20000 30000 40000]]
	--assert (v * 10.0)  = make vector! [unsigned integer! 16 [34464 3392 37856 6784]]

--test-- "VECTOR 16bit integer divide"
	v: make vector! [unsigned integer! 16 [80 160 240 320]]
	v / 20 / 2
	divide v 2
	--assert v = make vector! [unsigned integer! 16 [1 2 3 4]]
	--assert error? try [10 / v]
	--assert error? try [ v / 0] 

--test-- "VECTOR 32bit decimal add/subtract"
	v: make vector! [decimal! 32 [1 2 3 4]]
	--assert (v + 200) = make vector! [decimal! 32 [201 202 203 204]]
	--assert (v + 0.5) = make vector! [decimal! 32 [201.5 202.5 203.5 204.5]]
	; notice the precision lost with 32bit decimal value:
	v - 0.1
	--assert 2013 = to integer! 10 * v/1 ; result is not 201.4 as would be with 64bit

--test-- "VECTOR 64bit decimal add/subtract"
	v: make vector! [decimal! 64 [1 2 3 4]]
	--assert (v + 200) = make vector! [decimal! 64 [201 202 203 204]]
	--assert (v + 0.5) = make vector! [decimal! 64 [201.5 202.5 203.5 204.5]]
	--assert (v - 0.1) = make vector! [decimal! 64 [201.4 202.4 203.4 204.4]]

--test-- "VECTOR 64bit decimal multiply/divide"
	v: make vector! [decimal! 64 [1 2 3 4]]
	--assert (v * 20.5) = make vector! [decimal! 64 [20.5 41.0 61.5 82.0]]
	--assert (v / 20.5) = make vector! [decimal! 64 [1.0 2.0 3.0 4.0]]

--test-- "VECTOR math operation with vector not at head"
	v: make vector! [integer! 8 [1 2 3 4]]
	--assert (2 + skip v 2) = make vector! [integer! 8 [5 6]]
	--assert v = make vector! [integer! 8 [1 2 5 6]]

===end-group===

~~~end-file~~~