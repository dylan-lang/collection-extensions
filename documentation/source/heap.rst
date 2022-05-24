The heap Module
===============

.. current-library:: collection-extensions
.. current-module:: vector-search

Overview
--------

A heap is an implementation of the abstract data type "sorted list". A heap
is a sorted sequence of items.  Most likely the user will end up writing
something like

.. code-block:: dylan

   define class <heap-item> (<object>)
     slot priority;
     slot data;
   end;

with appropriate methods defined for :drm:`<` and :drm:`=`. The user could,
however, have simply a sorted list of integers, or have some item where the
priority is an integral part of the item itself.

:drm:`make` on heaps supports the ``less-than:`` keyword, which supply the
heap's comparison and defaults to :drm:`<`.

Heaps support all the usual sequence operations. The most useful ones::

     heap-push(heap, item) => updated-heap
     heap-pop(heap)        => smallest-element
     first(heap)           => smallest-element
     second(heap)          => second-smallest-element
     add!(heap, item)      => updated-heap
     sort, sort!           => sorted-sequence

These are all "efficient" operations (defined below).  As with :drm:`push` on
:drm:`<deque>`, :func:`heap-push` is another name for :drm:`add!`, and does
exactly the same thing except that heap-push doesn't accept any keywords.
:drm:`sort` and :drm:`sort!` return a sequence that's not a heap. Not
necessarily efficient but useful anyhow::

     add-new!(heap, item, #key test:, efficient:) => updated-heap
     remove!(heap, item, #key test:, efficient:) => updated-heap
     member?(item, heap, #key test:, efficient:) => <boolean>

The ``efficient:`` keyword defaults to ``#f``. If ``#t``, it uses the
:func:`random-iteration-protocol` (which is considerably more efficient, but
isn't really standard behavior, so it had to be optional).  Conceivably most
sequence methods could support such a keyword, but they don't yet.

The user can use :drm:`element-setter` or the iteration protocol to change an
item in the heap, but changing the priority of an item is an error and Bad
Things(tm) will happen. No error will be signaled.  Both of these operations
are very inefficient.

Heaps are **not** instances of :drm:`<stretchy-collection>`, although
:drm:`add!` and :func:`heap-pop` can magically change the size of the heap.

Efficiency: Approximate running times of different operations are given
below: (N is the size of the heap) ::

    first, first-setter                             O(1)
    second (but not second-setter)                  O(1)
    size                                            O(1)
    add!                                            O(lg N)
    heap-push                                       O(lg N)
    heap-pop(heap)                                  O(lg N)
    sort, sort!                                     O(N * lg N)
    forward-iteration-protocol
                            setup:                  O(N)
                            next-state:             O(lg N)
                            current-element:        O(1)
                            current-element-setter: O(N)
    backward-iteration-protocol
                            setup:                  O(N * lg N)
                            next-state:             O(1)
                            current-element:        O(1)
                            current-element-setter: O(N)
    random-iteration-protocol
                            setup:                  O(1)
                            next-state:             O(1)
                            current-element:        O(1)
                            current-element-setter: O(1)
    element(heap, M)                                O(M*lg N + N)
    element-setter(value, heap, M)                  O(N + M*lg N + M)

:drm:`element`, :drm:`element-setter` on arbitrary keys use the
:drm:`forward-iteration-protocol` (via the inherited methods), and have
accordingly bad performance.

Reference
---------

The HEAP module
***************

.. current-module:: heap


.. class:: <heap>

   :superclasses: :drm:`<mutable-sequence>`

   :keyword less-than: An instance of :drm:`<object>`.
   :keyword size: An instance of :drm:`<object>`.

.. generic-function:: heap-pop

   :signature: heap-pop (h) => (smallest-item)

   :parameter h: An instance of :class:`<heap>`.
   :value smallest-item: An instance of :drm:`<object>`.

.. generic-function:: heap-push

   :signature: heap-push (h new-elt) => (changed-heap)

   :parameter h: An instance of :class:`<heap>`.
   :parameter new-elt: An instance of :drm:`<object>`.
   :value changed-heap: An instance of :class:`<heap>`.

.. generic-function:: random-iteration-protocol

   :signature: random-iteration-protocol (collection) => (initial-state limit next-state finished-state? current-key current-element current-element-setter copy-state)

   :parameter collection: An instance of :class:`<heap>`.
   :value initial-state: An instance of :drm:`<object>`.
   :value limit: An instance of :drm:`<object>`.
   :value next-state: An instance of :drm:`<function>`.
   :value finished-state?: An instance of :drm:`<function>`.
   :value current-key: An instance of :drm:`<function>`.
   :value current-element: An instance of :drm:`<function>`.
   :value current-element-setter: An instance of :drm:`<function>`.
   :value copy-state: An instance of :drm:`<function>`.
