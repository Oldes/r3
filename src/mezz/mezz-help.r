REBOL [
	System: "REBOL [R3] Language Interpreter and Run-time Environment"
	Title: "REBOL 3 Mezzanine: Help"
	Rights: {
		Copyright 2012 REBOL Technologies
		REBOL is a trademark of REBOL Technologies
	}
	License: {
		Licensed under the Apache License, Version 2.0
		See: http://www.apache.org/licenses/LICENSE-2.0
	}
]

import module [
	Title:  "Help related functions"
	Name:    Help
	Version: 3.0.0
	Exports: [? help about usage what license source]
][
	buffer: none
	max-desc-width: 45

	help-text: {
  ^[[4;1;36mUse ^[[1;32mHELP^[[1;36m or ^[[1;32m?^[[1;36m to see built-in info^[[m:
  ^[[1;32m
      help insert
      ? insert
  ^[[m
  ^[[4;1;36mTo search within the system, use quotes^[[m:
  ^[[1;32m
      ? "insert"
  ^[[m
  ^[[4;1;36mTo browse online web documents^[[m:
  ^[[1;32m
      help/doc insert
  ^[[m
  ^[[4;1;36mTo view words and values of a context or object^[[m:
  
      ^[[1;32m? lib^[[m            - the runtime library
      ^[[1;32m? self^[[m           - your user context
      ^[[1;32m? system^[[m         - the system object
      ^[[1;32m? system/options^[[m - special settings
  
  ^[[4;1;36mTo see all words of a specific datatype^[[m:
  ^[[1;32m
      ? native!
      ? function!
      ? datatype!
  ^[[m
  ^[[4;1;36mOther debug functions^[[m:
  
      ^[[1;32m??^[[m      - display a variable and its value
      ^[[1;32mprobe^[[m   - print a value (molded)
      ^[[1;32msource^[[m  - show source code of func
      ^[[1;32mtrace^[[m   - trace evaluation steps
      ^[[1;32mwhat^[[m    - show a list of known functions
  
  ^[[4;1;36mOther information^[[m:
  
      ^[[1;32mabout^[[m   - see general product info
      ^[[1;32mlicense^[[m - show user license
      ^[[1;32musage^[[m   - program cmd line options
}

	output: func[value][
		buffer: insert buffer form reduce value
	]

	clip-str: func [str] [
		; Keep string to one line.
		unless string? str [str: mold str]
		trim/lines str
		if (length? str) > max-desc-width [str: append copy/part str max-desc-width "..."]
		str
	]

	interpunction: charset ";.?!"
	dot: func[value [string!]][
		unless find interpunction last value [append value #"."]
		value
	]

	pad: func [val [string!] size] [head insert/dup tail val #" " size - length? val]

	a-an: func [
		"Prepends the appropriate variant of a or an into a string"
		s [string!]
	][
		form reduce [pick ["an" "a"] make logic! find "aeiou" s/1 s]
	]

	form-type: func [value] [
		a-an head clear back tail mold type? :value
	]

	form-val: func [val] [
		; Form a limited string from the value provided.
		val: case [
			string?       :val [ mold val ]
			any-block?    :val [ return reform ["length:" length? val] ]
			object?       :val [ words-of val ]
			module?       :val [ words-of val ]
			any-function? :val [ any [title-of :val spec-of :val] ]
			datatype?     :val [ get in spec-of val 'title ]
			typeset?      :val [ to block! val]
			port?         :val [ reduce [val/spec/title val/spec/ref] ]
			image?        :val [ return reform ["size:" val/size] ]
			gob?          :val [ return reform ["offset:" val/offset "size:" val/size] ]
			;none?         :val [ mold/all val]
			true [:val]
		]
		clip-str val
	]

	form-pad: func [val size] [
		; Form a value with fixed size (space padding follows).
		val: form val
		insert/dup tail val #" " size - length? val
		val
	]

	out-form-obj: func [
		"Returns a block of information about an object or port"
		obj [any-object!]
		/weak "Provides sorting and does not displays unset values"
		/match "Include only those that match a string or datatype"
			pattern
		/local start wild type str
	][
		start: buffer
		; Search for matching strings:
		wild: all [string? pattern  find pattern "*"]
		foreach [word val] obj [
			type: type?/word :val
			str: either find [function! closure! native! action! op! object!] type [
				reform [word mold spec-of :val words-of :val]
			][
				form word
			]
			if any [
				not match
				all [
					not unset? :val
					either string? :pattern [
						either wild [
							tail? any [find/any/match str pattern pattern]
						][
							find str pattern
						]
					][
						type = :pattern
					]
				]
			][
				unless all [weak type = unset!][
					str: join "^[[1;32m" form-pad word 15
					append str "^[[m "
					append str form-pad type 11 - min 0 ((length? str) - 15)
					output ["  " str "^[[32m" form-val :val "^[[m^/"]
				]
			]
		]
		if all [pattern buffer = start] [
			buffer: insert buffer reduce ["No information on: ^[[32m" pattern "^[[m^/"]
		]
		buffer
	]

	out-description: func [des [block!]][
		foreach line des [
			uppercase/part trim/lines line 1
			dot line
		]
		buffer: insert insert buffer #" " form des 
	]

	?: help: func [
		"Prints information about words and values"
		'word [any-type!]
		/into "Help text will be inserted into provided string instead of printed"
			string [string!] "Returned series will be past the insertion"
		/local value spec args refs type ret desc arg def des tmp
	][
		try [
			tmp: query system/ports/input
			max-desc-width: tmp/window-size/x - 36
		]
		buffer: any [string  make string! 1024]
		catch [
			case/all [
				unset? :word [
					output help-text
					throw true
				]
				word? :word [
					either value? :word [
						value: get :word    ;lookup for word's value if any
					][	word: mold :word ]  ;or use it as a string input
				]
				string? :word  [
					out-form-obj/weak/match system/contexts/lib :word
					throw true
				]
				datatype? :value [
					output ajoin ["^[[1;32m" uppercase mold :word "^[[m is a datatype of value: ^[[32m" mold :value "^[[m^/"]
					out-form-obj/match system/contexts/lib :word
					throw true
				]
				not any [word? :word path? :word] [
					output [mold :word "is" form-type :word]
					throw true
				]
				path? :word [
					if any [
						error? set/any 'value try [get :word]
						not value? :value
					] [
						output ["No information on" word "(path has no value)"]
						throw true
					]
				]
				any-function? :value [
					spec: copy/deep spec-of :value
					args: copy []
					refs: none
					type: type? :value
					
					clear find spec /local
					parse spec [
						any block!
						copy desc any string!
						any [
							set arg [word! | lit-word! | get-word!] 
							set def opt block!
							copy des any string! (
								repend args [arg def des]
							)
							opt [set-word! block!]
						]
						opt [refinement! refs:]
						to end
					]
					output "^[[4;1;36mUSAGE^[[m:^/     "
					either op? :value [
						output [args/1 word args/4]
					] [
						output ajoin ["^[[1;32m" uppercase mold word]
						foreach [arg def des] args [
							buffer: insert insert buffer #" " mold arg
						]
						output "^[[m"
					]

					output "^/^/^[[4;1;36mDESCRIPTION^[[m:^/"
					unless empty? desc [
						foreach line desc [
							trim/head/tail line
							unless empty? line [
								output ["    " dot uppercase/part line 1 #"^/"]
							]
						]
					]
					output ["    " uppercase form word "is" a-an mold type "value."]

					unless empty? args [
						output "^/^/^[[4;1;36mARGUMENTS^[[m:"
						foreach [arg def des] args [
							output ajoin [
								"^/     ^[[1;32m" pad mold arg 14 "^[[m"
								"^[[32m" pad either def [mold def]["[any-type!]"] 10 "^[[m"
							]
							out-description des
						]
					]

					if refs [
						output "^/^/^[[4;1;36mREFINEMENTS^[[m:"
						parse back refs [
							any [
								set tmp refinement! (output ajoin ["^/     ^[[1;32m" pad mold tmp 14 "^[[m"])
								opt [set tmp string! (output tmp)]
								any [
									set arg [word! | lit-word! | get-word!] 
									set def opt block! 
									copy des any string! (
										output [
											"^/    "
											"^[[1;33m" pad form arg 11  
											"^[[0;32m" either def [mold def]["[any-type!]"] "^[[m"
										]
										out-description des
									)
								]
							]
						]
					]
					throw true
				]
				'else [
					output ajoin ["^[[1;32m" uppercase mold word "^[[m is " form-type :value " of value: ^[[32m"]
					either any [any-object? value] [output lf out-form-obj :value] [output mold :value]
					output "^[[m"
				]
			]
		]
		also
			either into [buffer][print head buffer]
			buffer: none
	]

	about: func [
		"Information about REBOL"
	][
		print make-banner sys/boot-banner
	]

	usage: func [
		"Prints command-line arguments"
	][
		print {
  ^[[4;1;36mCommand line usage^[[m:
  
      ^[[1;32mREBOL |options| |script| |arguments|^[[m
  
  ^[[4;1;36mStandard options^[[m:
  
      ^[[1;32m--args data^[[m      Explicit arguments to script (quoted)
      ^[[1;32m--do expr^[[m        Evaluate expression (quoted)
      ^[[1;32m--help (-?)^[[m      Display this usage information
      ^[[1;32m--script file^[[m    Explicit script filename
      ^[[1;32m--version tuple^[[m  Script must be this version or greater
  
  ^[[4;1;36mSpecial options^[[m:
  
      ^[[1;32m--boot level^[[m     Valid levels: base sys mods
      ^[[1;32m--debug flags^[[m    For user scripts (system/options/debug)
      ^[[1;32m--halt (-h)^[[m      Leave console open when script is done
      ^[[1;32m--import file^[[m    Import a module prior to script
      ^[[1;32m--quiet (-q)^[[m     No startup banners or information
      ^[[1;32m--secure policy^[[m  Can be: none allow ask throw quit
      ^[[1;32m--trace (-t)^[[m     Enable trace mode during boot
      ^[[1;32m--verbose^[[m        Show detailed startup information
  
  ^[[4;1;36mOther quick options^[[m:
  
      ^[[1;32m-s^[[m               No security
      ^[[1;32m+s^[[m               Full security
      ^[[1;32m-v^[[m               Display version only (then quit)
  
  ^[[4;1;36mExamples^[[m:
  
      REBOL script.r
      REBOL -s script.r
      REBOL script.r 10:30 test@example.com
      REBOL --do "watch: on" script.r}

      ; --cgi (-c)       Load CGI utiliy module and modes
	]


	license: func [
		"Prints the REBOL/core license agreement"
	][
		print system/license
	]

	source: func [
		"Prints the source code for a word"
		'word [word! path!]
	][
		if not value? word [print [word "undefined"] exit]
		print head insert mold get word reduce [word ": "]
		exit
	]

	what: func [
		{Prints a list of known functions}
		'name [word! lit-word! unset!] "Optional module name"
		/args "Show arguments not titles"
		/local ctx vals arg list size
	][
		list: make block! 400
		size: 10 ; defines minimal function name padding

		ctx: any [select system/modules :name lib]

		foreach [word val] ctx [
			if any-function? :val [
				arg: either args [
					arg: words-of :val
					clear find arg /local
					mold arg
				][
					title-of :val
				]
				append list reduce [word arg]
				size: max size length? word
			]
		]
		size: min size 18 ; limits function name padding to be max 18 chars
		vals: make string! size
		foreach [word arg] sort/skip list 2 [
			append/dup clear vals #" " size
			print rejoin ["^[[1;32m" head change vals word "^[[0m " any [arg ""]]
		]
		exit
	]
]

;-- old alpha functions:
;pending: does [
;	comment "temp function"
;	print "Pending implementation."
;]
;
;say-browser: does [
;	comment "temp function"
;	print "Opening web browser..."
;]
;
;upgrade: function [
;	"Check for newer versions (update REBOL)."
;][
;	print "Fetching upgrade check ..."
;	if error? err: try [do http://www.rebol.com/r3/upgrade.r none][
;		either err/id = 'protocol [print "Cannot upgrade from web."][do err]
;	]
;	exit
;]
;
;chat: function [
;	"Open REBOL DevBase forum/BBS."
;][
;	print "Fetching chat..."
;	if error? err: try [do http://www.rebol.com/r3/chat.r none][
;		either err/id = 'protocol [print "Cannot load chat from web."][do err]
;	]
;	exit
;]
;
;docs: func [
;	"Browse on-line documentation."
;][
;	say-browser
;	browse http://www.rebol.com/r3/docs
;	exit
;]
;
;bugs: func [
;	"View bug database."
;][
;	say-browser
;	browse http://curecode.org/rebol3/
;	exit
;]
;
;changes: func [
;	"What's new about this version."
;][
;	say-browser
;	browse http://www.rebol.com/r3/changes.html
;	exit
;]
;
;why?: func [
;	"Explain the last error in more detail."
;	'err [word! path! error! none! unset!] "Optional error value"
;][
;	case [
;		unset? :err [err: none]
;		word? err [err: get err]
;		path? err [err: get err]
;	]
;
;	either all [
;		error? err: any [:err system/state/last-error]
;		err/type ; avoids lower level error types (like halt)
;	][
;		say-browser
;		err: lowercase ajoin [err/type #"-" err/id]
;		browse join http://www.rebol.com/r3/docs/errors/ [err ".html"]
;	][
;		print "No information is available."
;	]
;	exit
;]
;
;demo: function [
;	"Run R3 demo."
;][
;	print "Fetching demo..."
;	if error? err: try [do http://www.rebol.com/r3/demo.r none][
;		either err/id = 'protocol [print "Cannot load demo from web."][do err]
;	]
;	exit
;]
;
;load-gui: function [
;	"Download current GUI module from web. (Temporary)"
;][
;	print "Fetching GUI..."
;	either error? data: try [load http://www.rebol.com/r3/gui.r][
;		either data/id = 'protocol [print "Cannot load GUI from web."][do err]
;	][
;		do data
;	]
;	exit
;]
