Rebol [
	Title:   "Rebol3 date test script"
	Author:  "Oldes, Peter W A Wood"
	File: 	 %date-test.r3
	Tabs:	 4
	Needs:   [%../quick-test-module.r3]
]

~~~start-file~~~ "date"

===start-group=== "ISO8601 subset"
	--test-- "ISO8601 basic load"
		--assert 8-Nov-2013/17:01 = load "2013-11-08T17:01"
		--assert 8-Nov-2013/17:01 = load "2013-11-08T17:01Z"
		--assert 8-Nov-2013/17:01+1:00 = load "2013-11-08T17:01+0100"
		--assert 8-Nov-2013/17:01-1:00 = load "2013-11-08T17:01-0100"
		--assert 8-Nov-2013/17:01+1:00 = load "2013-11-08T17:01+01:00"
	--test-- "basic load of not fully standard ISO8601"
		--assert 8-Nov-2013/17:01 = load "2013/11/08T17:01"
		--assert 8-Nov-2013/17:01 = load "2013/11/08T17:01Z"
		--assert 8-Nov-2013/17:01+1:00 = load "2013/11/08T17:01+0100"
		--assert 8-Nov-2013/17:01+1:00 = load "2013/11/08T17:01+01:00"
	--test-- "Invalid ISO8601 dates"
		--assert error? try [load "2013-11-08T17:01Z0100"]
		--assert error? try [load "2013/11/08T17:01Z0100"]

	--test-- "Using ISO88601 datetime in a path"
		;@@ https://github.com/rebol/rebol-issues/issues/2089
		b: [8-Nov-2013/17:01 "foo"]
		--assert "foo" = b/2013-11-08T17:01

===end-group===

===start-group=== "MOLD/ALL on date"
;-- producing ISO8601 valid result (https://tools.ietf.org/html/rfc3339)
	--test-- "MOLD/ALL on date"
		--assert "2000-01-01T01:02:03" = mold/all 1-1-2000/1:2:3
		--assert "2000-01-01T10:20:03" = mold/all 1-1-2000/10:20:3
		--assert "0200-01-01T01:02:03" = mold/all 1-1-200/1:2:3
		--assert "0200-01-01T01:02:03+02:00" = mold/all 1-1-200/1:2:3+2:0
		--assert "0200-01-01T01:02:03+10:00" = mold/all 1-1-200/1:2:3+10:0

===end-group===

===start-group=== "TO DATE!"
	--test-- "invalid input"
		;@@ https://github.com/rebol/rebol-issues/issues/878
		--assert error? try [to date! "31-2-2009"]
		--assert error? try [to date! [31 2 2009]]

===end-group===

===start-group=== "Date math"
	--test-- "adding by integer"
		;@@ https://github.com/rebol/rebol-issues/issues/213
		n: now
		--assert not error? try [now/date + 1]
		--assert not error? try [d1: n + 1]
		--assert not error? try [d2: n/date + 1]
		--assert d1/date = d2/date

===end-group===

===start-group=== "Various date issues"
	--test-- "issue 1637"
		;@@ https://github.com/rebol/rebol-issues/issues/1637
		d: now/date
		--assert none? d/time
		--assert none? d/zone
		d: make date! [23 7 2010]
		--assert none? d/time
		d: now/date
		--assert none? d/time
		d: d/date
		--assert none? d/time

	--test-- "issue 1308"
		;@@ https://github.com/rebol/rebol-issues/issues/1308
		d: 28-Oct-2009/10:09:38-7:00
		--assert 28-Oct-2009/17:09:38 = d/utc
		--assert 10 = d/hour

===end-group===

	
~~~end-file~~~
