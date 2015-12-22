Module:    collection-extensions-test-suite
Synopsis:  The test suite for the heap module.
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

define test basic-integer-heap ()
  let h = make(<heap>);
  heap-push(h, 3);
  heap-push(h, 1);

  // the heap looks sane
  assert-equal(2, h.size);
  assert-equal(1, h[0]);
  assert-equal(3, h[1]);

  // member works for the elements in the heap
  assert-true(member?(1, h));
  assert-true(member?(3, h));

  // and not for something not in the heap
  assert-false(member?(2, h));

  // popping from the heap returns the right value
  assert-equal(1, heap-pop(h));

  // and the heap looks sane after the heap-pop.
  assert-equal(1, h.size);
  assert-false(member?(1, h));
  assert-equal(3, h[0]);
end test basic-integer-heap;

define test heap-empty ()
  let h = make(<heap>);

  // Heap starts out empty
  assert-true(h.empty?);

  // Adding something makes it non-empty.
  heap-push(h, 2);
  assert-false(h.empty?);

  // And removing it makes it empty again.
  heap-pop(h);
  assert-true(h.empty?);
end test heap-empty;

define test heap-coercion ()
  let h = as(<heap>, #[4, 6, 5, 1]);

  assert-equal(4, h.size);
  assert-equal(1, heap-pop(h));
  assert-equal(4, heap-pop(h));
  assert-equal(5, heap-pop(h));
  assert-equal(6, heap-pop(h));
end test heap-coercion;

define test heap-removal ()
  let h = as(<heap>, #[2, 4, 4, 6, 4, 6]);
  assert-equal(6, h.size);

  remove!(h, 6);
  assert-equal(4, h.size);

  remove!(h, 4, count: 1);
  assert-equal(3, h.size);

  remove!(h, 4, count: 100);
  assert-equal(1, h.size);
end test heap-removal;

define suite heap-suite
    (description: "Test suite for the heap module.")
  test basic-integer-heap;
  test heap-empty;
  test heap-coercion;
  test heap-removal;
end suite heap-suite;
