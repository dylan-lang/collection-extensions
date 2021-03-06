module:   heap
author:   Nick Kramer (nkramer@cs.cmu.edu)
synopsis: Provides <heap>, a popular data structure for priority queues.
          The semantics are basically those of a sorted sequence, with
          particularly efficient implementations of add!, first, and
          heap-pop (i.e.  "remove-first").

//======================================================================
//
// Copyright (c) 1994  Carnegie Mellon University
// Copyright (c) 1998, 1999, 2000  Gwydion Dylan Maintainers
// All rights reserved.
//
// Use and copying of this software and preparation of derivative
// works based on this software are permitted, including commercial
// use, provided that the following conditions are observed:
//
// 1. This copyright notice must be retained in full on any copies
//    and on appropriate parts of any derivative works.
// 2. Documentation (paper or online) accompanying any system that
//    incorporates this software, or any part of it, must acknowledge
//    the contribution of the Gwydion Project at Carnegie Mellon
//    University, and the Gwydion Dylan Maintainers.
//
// This software is made available "as is".  Neither the authors nor
// Carnegie Mellon University make any warranty about the software,
// its performance, or its conformity to any specification.
//
// Bug reports should be sent to <gd-bugs@gwydiondylan.org>; questions,
// comments and suggestions are welcome at <gd-hackers@gwydiondylan.org>.
// Also, see http://www.gwydiondylan.org/ for updates and documentation.
//
//======================================================================

//============================================================================
// A heap is an implementation of the abstract data type "sorted list". A heap
// is a sorted sequence of items.  Most likely the user will end up writing
// something like
//
// define class <heap-item> (<object>);
//   slot priority;
//   slot data;
// end class <heap-item>;
//
// with appropriate methods defined for < and =. The user could, however, have
// simply a sorted list of integers, or have some item where the priority is
// an integral part of the item itself.
//
// make on heaps supports the less-than: keyword, which supply the heap's
// comparison and defaults to <.
//
// Heaps support all the usual sequence operations. The most useful ones:
//
//      heap-push(heap, item) => updated-heap
//      heap-pop(heap)        => smallest-element
//      first(heap)           => smallest-element
//      second(heap)          => second-smallest-element
//      add!(heap, item)      => updated-heap
//      sort, sort!           => sorted-sequence
//
// These are all "efficient" operations (defined below).  As with push on <deque>,
// heap-push is another name for add!, and does exactly the same thing except that
// heap-push doesn't accept any keywords.  sort and sort! return a sequence that's
// not a heap. Not necessarily efficient but useful anyhow:
//
//      add-new!(heap, item, #key test:, efficient:) => updated-heap
//      remove!(heap, item, #key test:, efficient:) => updated-heap
//      member?(item, heap, #key test:, efficient:) => <boolean>
//
// The efficient: keyword defaults to #f. If #t, it uses the
// random-iteration-protocol (which is considerably more efficient, but isn't
// really standard behavior, so it had to be optional).  Conceivably most
// sequence methods could support such a keyword, but they don't yet.
//
// The user can use element-setter or the iteration protocol to change an item
// in the heap, but changing the priority of an item is an error and Bad
// Things(tm) will happen. No error will be signaled.  Both of these
// operations are very inefficient.
//
// Heaps are NOT <stretchy-collection>s, although add! and heap-pop can
// magically change the size of the heap.
//
// Efficiency: Approximate running times of different operations are given
// below: (N is the size of the heap)
//
//     first, first-setter                             O(1)
//     second (but not second-setter)                  O(1)
//     size                                            O(1)
//     add!                                            O(lg N)
//     heap-push                                       O(lg N)
//     heap-pop(heap)                                  O(lg N)
//     sort, sort!                                     O(N * lg N)
//     forward-iteration-protocol
//                             setup:                  O(N)
//                             next-state:             O(lg N)
//                             current-element:        O(1)
//                             current-element-setter: O(N)
//     backward-iteration-protocol
//                             setup:                  O(N * lg N)
//                             next-state:             O(1)
//                             current-element:        O(1)
//                             current-element-setter: O(N)
//     random-iteration-protocol
//                             setup:                  O(1)
//                             next-state:             O(1)
//                             current-element:        O(1)
//                             current-element-setter: O(1)
//     element(heap, M)                                O(M*lg N + N)
//     element-setter(value, heap, M)                  O(N + M*lg N + M)
//
// element, element-setter on arbitrary keys use the
// forward-iteration-protocol (via the inherited methods), and have
// accordingly bad performance.
//============================================================================


define class <heap> (<mutable-sequence>)
  slot heap-size      :: <integer>, init-value: 0;
  slot heap-data      :: <stretchy-vector>;
  slot heap-less-than :: <function>;
end class <heap>;

// The size: keyword is accepted but ignored
//
define method initialize
    (h :: <heap>,
     #key size: size,
          less-than: less-than = \<)
  next-method();
  h.heap-data      := make(<stretchy-vector>);
  h.heap-less-than := less-than;
end method initialize;

define method type-for-copy (h :: <heap>) => (type :: <type>)
  <stretchy-vector>
end method type-for-copy;

define method shallow-copy (old-heap :: <heap>) => (new-heap :: <heap>)
  let new-heap = make(<heap>);
  new-heap.heap-size := old-heap.heap-size;
  new-heap.heap-data := shallow-copy(old-heap.heap-data);
  new-heap.heap-less-than := old-heap.heap-less-than;
  new-heap
end method shallow-copy;


define method as(cls == <heap>, coll :: <collection>)
 => (result :: <heap>)
  let heap = make(<heap>);
  for (elem in coll)
    add!(heap, elem);
  end for;
  heap
end method as;


define method size (h :: <heap>) => (size :: <integer>)
  h.heap-size
end method size;


define method empty? (h :: <heap>) => (answer :: <boolean>)
  h.heap-size = 0
end method empty?;


define constant no-default = "no-default";

// Special case the top, which can be done efficiently because we
// don't have to call the iteration protocol.
//
define method element
    (h :: <heap>, index == 0,
     #key default = no-default)
 => (elt :: <object>)
  if (empty?(h))
    if (default == no-default)
      error("No such element")
    else
      default
    end if
  else
    h.heap-data[0]
  end if
end method element;


// Special case the second as well because it can be done
// semi-efficiently (again, no iteration protocol)
//
define method element
    (h :: <heap>, index == 1,
     #key default = no-default)
 => (elt :: <object>)
  if (size(h) < 2)
    if (default == no-default)
      error("No such element")
    else
      default
    end if
  else
    h.heap-data[smaller-child(h, 0)]
  end if
end method element;


define method element
    (h :: <heap>, index :: <integer>,
     #key default = no-default)
 => (elt :: <object>)
  let (initial-state, limit, next-state, finished?, current-key,
       current-element,current-element-setter)
    = forward-iteration-protocol(h);
  for (state = initial-state then next-state(h, state),
       counter = index then counter - 1,
       until: (counter <= 0) | finished?(h, state, limit))
  finally
    if (counter == 0)
      current-element(h, state)
    elseif (default == no-default)
      error("element: <heap> has no %dth element", index);
    else
      default
    end if
  end for
end method element;


// Inherit inefficient element-setter

// Special case the top, which can be done efficiently and without the
// iteration protocol
//
define method element-setter (value, h :: <heap>, index == 0)
 => (value :: <object>)
  h.heap-data[0] := value;
  value
end method element-setter;


// element-setter uses element to figure out which element is the
// key'th biggest, and then traverses the internal data structure
// (through a call to find-index) to find that element in order to
// change it.
//
define method element-setter (new-elt, h :: <heap>, key :: <integer>)
 => (value :: <object>)
  h.heap-data [find-index(h, h[key])] := new-elt;
end method element-setter;

define method add! (h :: <heap>, new-elt)
 => (changed-heap :: <heap>)
  h.heap-data [h.heap-size] := new-elt;
  h.heap-size := 1 + h.heap-size;
  upheap(h, h.heap-size - 1);
  h
end method add!;

define method add-new!
    (h :: <heap>, new-elt,
     #key test: test = \=,
          efficient: efficient = #f)
 => (changed-heap :: <heap>)
  if (~ member?(new-elt, h, test: test, efficient: efficient))
    add!(h, new-elt)
  else
    h
  end if
end method add-new!;

define method heap-push (h :: <heap>, new-elt)
 => (changed-heap :: <heap>)
  add!(h, new-elt)
end method heap-push;

define method heap-pop (h :: <heap>)
 => (smallest-item :: <object>)
  let smallest-item = h.heap-data [0];
  h.heap-data [0] := h.heap-data [size(h) - 1];
//  remove!(h.heap-data, size(h) - 1);    // Adjust stretchy vector
  h.heap-size := h.heap-size - 1;
  downheap(h, 0);
  smallest-item
end method heap-pop;


// This is rather complicated because it can use two different
// iteration protocols and has to be able to remove an arbitrary
// number of items from the heap. Further complicating it, removing an
// element from the heap disturbs it, so you have to FIND the
// elements to remove, THEN remove them.
//
define method remove!
    (h :: <heap>, elt,
     #key test: test = \=,
          efficient: efficient = #f,
          count :: <integer> = h.heap-size)
    => changed-heap :: <heap>;
  let (init, limit, next, finished?, cur-key, cur-elt) =
    if (efficient)     random-iteration-protocol(h);
    else                forward-iteration-protocol(h);
    end if;

  let kill-list = #();

  let count :: <integer> = count | h.heap-size;
  for (state = init then next(h, state), until: finished?(h, state, limit))
    if ((count > 0) & test(elt, cur-elt(h, state)))
      kill-list := add!(kill-list, cur-elt(h, state));
      count := count - 1;
    end if;
  end for;

  for (dead-elt in kill-list)
    let index = find-index(h, dead-elt);
    let old-item = h.heap-data[index];
    h.heap-size := h.heap-size - 1;
    h.heap-data[index] := h.heap-data[h.heap-size];
    let new-item = h.heap-data[index];

    if (h.heap-less-than(old-item, new-item))
      upheap(h, index);
    elseif (h.heap-less-than(new-item, old-item))
      downheap(h, index);
    end if;
  end for;

  h;
end method remove!;


define method member?
    (elt, h :: <heap>,
     #key test: test = \=,
      efficient: efficient = #f)
 => (answer :: <boolean>)
  let (init, limit, next, finished?, cur-key, cur-elt) =
    if (efficient)      random-iteration-protocol(h);
    else                forward-iteration-protocol(h);
    end if;

  block (return)
    for (state = init then next(h, state), until: finished?(h, state, limit))
      if (test(elt, cur-elt(h, state)))
        return(#t);
      end if;
    end for;
    #f
  end block
end method member?;


// Can't use backward-iteration-protocol because that uses reverse
//
define method reverse (h :: <heap>)
 => (reversed :: <sequence>)
  let new-seq = make(type-for-copy(h), size: size(h));
  for (elt in h, index = size(h) - 1  then index - 1)
    new-seq[index] := elt;
  end for;
  new-seq
end method reverse;


define method reverse! (h :: <heap>)
 => (reversed :: <sequence>)
  reverse(h)
end method reverse!;


define method sort
    (h :: <heap>,
     #key test: test = \<,
          stable: stable = #f)
 => (sorted :: <sequence>)
  if (test == h.heap-less-than)
    let new-seq = make(type-for-copy(h), size: size(h));
    for (elt in h, index = 0 then index + 1)
      new-seq[index] := elt;
    end for;
    new-seq
  else
    sort(h.heap-data, test: test, stable: stable)
  end if
end method sort;


define method sort!
    (h :: <heap>,
     #rest all-keys,
     #key test, stable)
 => (sorted :: <sequence>)
  apply(sort, h, all-keys)
end method sort!;

// ---------------------------------------------------------------------
// Internal functions
// ---------------------------------------------------------------------

// All internal operations specify things by their index into the vector.

define method parent (index :: <integer>)
 => (parent-index :: <integer>)
  floor/(index - 1, 2)
end method parent;


define method left-child (index :: <integer>)
 => (left-child-index :: <integer>)
  2 * index + 1
end method left-child;


define method right-child (index :: <integer>)
 => (right-child-index :: <integer>)
  2 * index + 2
end method right-child;


// Assumes the left child is valid, although the right child might not be.
//
define method smaller-child (h :: <heap>, index :: <integer>)
 => (smaller-child-index :: <integer>)
  if (right-child(index) = size(h))
    left-child(index)            // There is no right child
  elseif (h.heap-less-than(h.heap-data [right-child(index)],
                           h.heap-data [left-child(index)]))
    right-child(index)
  else
    left-child(index)
  end if
end method;


// Move a small item up
//
define method upheap (h :: <heap>, index :: <integer>) => ()
  let item = h.heap-data [index];

  while (index ~= 0   &
           h.heap-less-than (item, h.heap-data [parent(index)]))
    h.heap-data [index] := h.heap-data [parent(index)];
    index := parent(index);
  end while;
  h.heap-data [index] := item;
end method upheap;


// Move a big item down
//
define method downheap (h :: <heap>, index :: <integer>) => ()
  let item = h.heap-data [index];

  while ( left-child(index) < size(h)
           & h.heap-less-than(h.heap-data [smaller-child(h,index)], item))
    h.heap-data [index] := h.heap-data [smaller-child(h,index)];
    index := smaller-child(h,index);
  end while;

  h.heap-data [index] := item;
end method downheap;


define method find-index (h :: <heap>, elt)
 => (index :: <integer>)
  let index = 0;
  until (h.heap-data[index] == elt)
    index := index + 1;
  end until;
  index
end method find-index;

// ---------------------------------------------------------------------
// Iteration protocols
// ---------------------------------------------------------------------

// Not very efficient. Each next-state operation costs lg n (where n
// is the size of the heap), and it presumably costs N to set up.
//
define method forward-iteration-protocol (coll :: <heap>)
 => (initial-state :: <object>, limit :: <object>, next-state :: <function>,
     finished-state? :: <function>, current-key :: <function>,
     current-element :: <function>, current-element-setter :: <function>,
     copy-state :: <function>)
  values(shallow-copy(coll),          // initial-state
         #f,                          // limit (not used)
                                      // next-state
         method(h :: <heap>, state :: <heap>) => (new-state :: <heap>)
             heap-pop(state);
             state
         end method,

                                      // finished-state?
         method(h :: <heap>, state :: <heap>, limit)
             empty?(state)
         end method,

                                      // current-key
         method(h :: <heap>, state :: <heap>) => (key :: <integer>)
             h.heap-size - state.heap-size
         end method,

                                      // current-element
         method(h :: <heap>, state :: <heap>)
             first(state)
         end method,

                                      // current-element-setter
         method(value, h :: <heap>, state :: <heap>)
             let index = find-index(h, first(state));
             h.heap-data[index] := value;
             state.heap-data[0] := value;
         end method,

                                      // copy-state
         method(h :: <heap>, state :: <heap>) => (new-state :: <heap>)
             shallow-copy(state)
         end method)
end method forward-iteration-protocol;


// Not very efficient. Calling backward-iteration-protocol takes n lg n
// time, after which each access is constant time (except for
// current-element-setter, which is m lg n where m is the index of the
// element that's being changed).
//
define method backward-iteration-protocol (coll :: <heap>)
 => (initial-state :: <object>, limit :: <object>, next-state :: <function>,
     finished-state? :: <function>, current-key :: <function>,
     current-element :: <function>, current-element-setter :: <function>,
     copy-state :: <function>)
  let sorted-vector = reverse(coll);

  values(coll.heap-size - 1,          // initial-state
         -1,                          // limit
                                      // next-state
         method (h :: <heap>, state :: <integer>) => (new-state :: <integer>)
           state - 1
         end method,

                                      // finished-state?
         method (h :: <heap>, state :: <integer>, limit :: <integer>)
           state = limit
         end method,

                                      // current-key
         method (h :: <heap>, state :: <integer>) => (key :: <integer>)
           state
         end method,

                                      // current-element
         method (h :: <heap>, state :: <integer>)
           sorted-vector[state]
         end method,

                                      // current-element-setter
         method (value, h :: <heap>, state :: <integer>)
           let index = find-index(h, sorted-vector[state]);
           h.heap-data[index] := value;
           sorted-vector[state] := value;
         end method,

                                      // copy-state
         method (h :: <heap>, state :: <integer>) => (new-state :: <integer>)
             state
         end method)
end method backward-iteration-protocol;


// Just plows through the heap in the order things appear in the vector.
// Constant time access. Doesn't implement current-key.
//
define method random-iteration-protocol (collection :: <heap>)
 => (initial-state :: <object>, limit :: <object>, next-state :: <function>,
     finished-state? :: <function>, current-key :: <function>,
     current-element :: <function>, current-element-setter :: <function>,
     copy-state :: <function>);
  values(0,                      // initial-state
         size(collection),                // limit

                                 // next-state
         method (h :: <heap>, state :: <integer>) => (next-state :: <integer>)
           state + 1
         end method,

                                 // finished-state?
         method (h :: <heap>, state :: <integer>, limit :: <integer>)
           state = limit
         end method,

                                 // current-key
         method (h :: <heap>, state :: <integer>) => (key :: <integer>)
           error("I have no idea what the current-key is.");
         end method,

                                 // current-element
         method (h :: <heap>, state :: <integer>)
           h.heap-data [state];
         end method,

                                 // current-element-setter
         method (value, h :: <heap>, state :: <integer>)
           h.heap-data[state] := value
         end method,

                                 // copy-state
         method (h :: <heap>, state :: <integer>) => (state :: <integer>)
           state
         end method)
end method random-iteration-protocol;

