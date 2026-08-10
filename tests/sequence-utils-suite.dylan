Module:    collection-extensions-test-suite
Synopsis:  The test suite for the sequence-utilities module.
Author:    Matthias Hölzl (tc@xantira.com)
Copyright: See below.

// Copyright.
// =========

// Copyright (C) 2004 Dr. Matthias Hölzl.

//  Use and copying of this software and preparation of derivative
//  works based on this software are permitted, including commercial
//  use, provided that the following conditions are observed:
//
//  1. This copyright notice must be retained in full on any copies
//     and on appropriate parts of any derivative works. (Other names
//     and years may be added, so long as no existing ones are removed.)
//
//  This software is made available "as is".  Neither the authors nor
//  Carnegie Mellon University make any warranty about the software,
//  its performance, or its conformity to any specification.
//
//  Bug reports, questions, comments, and suggestions should be sent by
//  E-mail to the Internet address "gd-bugs@gwydiondylan.org".

// If you need to receive this library under another license contact
// the author (tc@xantira.com).


define test push-test (description: "Push! macro")
  let x = #();
  push!(x, 1);
  check-equal("Push integer on empty list", x, #(1));
  push!(x, 2);
  check-equal("Push integer on non-empty list", x, #(2, 1));
end test push-test;

define test pop-test (description: "Pop! macro")
  let x = list(1);
  check-equal("Pop singleton result", pop!(x), 1);
  check-equal("Pop singleton location", x, #());
end test pop-test;

define suite sequence-utilities-suite
    (description: "Test suite for the sequence-utilities module.")
  test push-test;
  test pop-test;
end suite sequence-utilities-suite;

define test test-zip-all-empty-values
    (description: "Testing zip-all with no arguments returns an empty list")
  expect-equal(#(), zip-all())
end test;

define test test-zip-empty-sequences
    (description: "Zip with empty sequences returns an empty list")
  expect-equal(#(), zip(#(), #()))
end test;

define test test-zip-single-element
    (description: "Test zip with single element sequences")
  expect-equal(#(#(10, 20)), zip(#(10), #(20)))
end test;

define test test-zip-two-sequences-equal-length
    (description: "Test zip with two sequences of equal length")
  expect-equal(#(#(1, 'a'), #(2, 'b'), #(3, 'c')),
	       zip(#(1, 2, 3), #('a', 'b', 'c')))
end test;

define test test-zip-with-keys
    (description: "Test zip passing key functons")
  expect-equal(#(#(#f, #t), #(#t, #f)),
	       zip(#(1, 2), #(3, 4),
		   key1: even?, key2: odd?))
end;

define test test-zip-two-sequences-unequal-length
    (description: "Test zip with two sequences of unequal length")
  let expected = #(#(1, 'a'), #(2, 'b'));
  expect-equal(expected, zip(#(1, 2), #('a', 'b', 'c')));
  expect-equal(expected, zip(#(1, 2, 3), #('a', 'b')));
end test;

define test test-zip-with
    (description: "Test zip with a math function")
  expect-equal(#(7, 10, 13, 16),
	       zip-with(method (x, y) 2 * x + y end,
			range(from: 1, to: 4),
			range(from: 5, to: 8)))
end test;

define test test-zip-all
    (description: "Testing zip with more than two sequences")
  expect-equal(#(#(1, 'x', #t), #(2, 'y', #f)),
 	       zip-all(#(1, 2, 3), #('x', 'y', 'z'), #(#t, #f)),
 	       "Testing zip with three sequences of unequal length");
  expect-equal(#(#(1, 'x', #t), #(2, 'y', #f)),
	       zip-all(#(1, 2), #('x', 'y', 'z'), #(#t, #f)),
	       "Testing zip with three sequences of unequal length");
end test;


define suite zip-suite
    (description: "Test suite for zip function")
  test test-zip-all-empty-values;
  test test-zip-empty-sequences;
  test test-zip-single-element;
  test test-zip-two-sequences-equal-length;
  test test-zip-two-sequences-unequal-length;
  test test-zip-with;
  test test-zip-all;
end suite;
