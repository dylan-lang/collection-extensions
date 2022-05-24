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
