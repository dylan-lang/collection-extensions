The sequence-utilities Module
=============================

.. current-library:: collection-extensions
.. current-module:: sequence-utilities

Overview
--------

The sequence-utilities module implements some useful methods on sequences.


Reference
---------

**TODO**: These docs are just an auto-generated skeleton so
far. https://github.com/dylan-lang/collection-extensions/issues/2

.. function:: alist-copy

   :signature: alist-copy (alist #key key datum cons) => (new-alist)

   :parameter alist: An instance of :drm:`<sequence>`.
   :parameter #key key: An instance of :drm:`<object>`.
   :parameter #key datum: An instance of :drm:`<object>`.
   :parameter #key cons: An instance of :drm:`<object>`.
   :value new-alist: An instance of :drm:`<sequence>`.

.. function:: alist-delete

   :signature: alist-delete (elt alist #key key test) => (#rest results)

   :parameter elt: An instance of :drm:`<object>`.
   :parameter alist: An instance of :drm:`<sequence>`.
   :parameter #key key: An instance of :drm:`<object>`.
   :parameter #key test: An instance of :drm:`<object>`.
   :value #rest results: An instance of :drm:`<object>`.

.. function:: apair

   :signature: apair (key datum aseq #key cons add) => (new-aseq)

   :parameter key: An instance of :drm:`<object>`.
   :parameter datum: An instance of :drm:`<object>`.
   :parameter aseq: An instance of :drm:`<sequence>`.
   :parameter #key cons: An instance of :drm:`<object>`.
   :parameter #key add: An instance of :drm:`<object>`.
   :value new-aseq: An instance of :drm:`<sequence>`.

.. function:: assoc

   :signature: assoc (elt seq #key key test) => (#rest results)

   :parameter elt: An instance of :drm:`<object>`.
   :parameter seq: An instance of :drm:`<sequence>`.
   :parameter #key key: An instance of :drm:`<object>`.
   :parameter #key test: An instance of :drm:`<object>`.
   :value #rest results: An instance of :drm:`<object>`.

.. generic-function:: choose-map

   :signature: choose-map (pred func seq #rest seqs) => (#rest results)

   :parameter pred: An instance of :drm:`<object>`.
   :parameter func: An instance of :drm:`<object>`.
   :parameter seq: An instance of :drm:`<object>`.
   :parameter #rest seqs: An instance of :drm:`<object>`.
   :value #rest results: An instance of :drm:`<object>`.

.. method:: choose-map
   :specializer: <function>, <function>, <sequence>

.. method:: choose-map
   :specializer: <function>, <function>, <list>

.. generic-function:: concatenate-map

   :signature: concatenate-map (func seq #rest seqs) => (#rest results)

   :parameter func: An instance of :drm:`<object>`.
   :parameter seq: An instance of :drm:`<object>`.
   :parameter #rest seqs: An instance of :drm:`<object>`.
   :value #rest results: An instance of :drm:`<object>`.

.. method:: concatenate-map
   :specializer: <function>, <sequence>

.. method:: concatenate-map
   :specializer: <function>, <list>

.. generic-function:: drop
   :open:

   :signature: drop (collection k) => (#rest results)

   :parameter collection: An instance of :drm:`<object>`.
   :parameter k: An instance of :drm:`<integer>`.
   :value #rest results: An instance of :drm:`<object>`.

.. method:: drop
   :specializer: <sequence>, <integer>

.. generic-function:: find

   :signature: find (pred seq #key failure) => (#rest results)

   :parameter pred: An instance of :drm:`<function>`.
   :parameter seq: An instance of :drm:`<sequence>`.
   :parameter #key failure: An instance of :drm:`<object>`.
   :value #rest results: An instance of :drm:`<object>`.

.. generic-function:: find-tail

   :signature: find-tail (pred seq) => (#rest results)

   :parameter pred: An instance of :drm:`<object>`.
   :parameter seq: An instance of :drm:`<object>`.
   :value #rest results: An instance of :drm:`<object>`.

.. method:: find-tail
   :specializer: <function>, <sequence>

.. method:: find-tail
   :specializer: <function>, <pair>

.. method:: find-tail
   :specializer: <function>, <empty-list>

.. function:: foldl

   :signature: foldl (cons nil lst) => (#rest results)

   :parameter cons: An instance of :drm:`<function>`.
   :parameter nil: An instance of :drm:`<object>`.
   :parameter lst: An instance of :drm:`<list>`.
   :value #rest results: An instance of :drm:`<object>`.

.. function:: foldr

   :signature: foldr (cons nil lst) => (#rest results)

   :parameter cons: An instance of :drm:`<function>`.
   :parameter nil: An instance of :drm:`<object>`.
   :parameter lst: An instance of :drm:`<list>`.
   :value #rest results: An instance of :drm:`<object>`.

.. function:: heads

   :signature: heads (lists) => (new-list)

   :parameter lists: An instance of :drm:`<list>`.
   :value new-list: An instance of :drm:`<list>`.

.. generic-function:: index

   :signature: index (elt seq #key test failure) => (index)

   :parameter elt: An instance of :drm:`<object>`.
   :parameter seq: An instance of :drm:`<sequence>`.
   :parameter #key test: An instance of :drm:`<object>`.
   :parameter #key failure: An instance of :drm:`<object>`.
   :value index: An instance of :drm:`<object>`.

.. function:: last-pair

   :signature: last-pair (lst) => (last-pair)

   :parameter lst: An instance of :drm:`<pair>`.
   :value last-pair: An instance of :drm:`<pair>`.

.. function:: list*

   :signature: list* (#rest rest) => (new-list)

   :parameter #rest rest: An instance of :drm:`<object>`.
   :value new-list: An instance of :drm:`<list>`.

.. generic-function:: list?

   :signature: list? (arg) => (#rest results)

   :parameter arg: An instance of :drm:`<object>`.
   :value #rest results: An instance of :drm:`<object>`.

.. method:: list?
   :specializer: <list>

.. method:: list?
   :specializer: <object>

.. generic-function:: null?

   :signature: null? (arg) => (#rest results)

   :parameter arg: An instance of :drm:`<object>`.
   :value #rest results: An instance of :drm:`<object>`.

.. method:: null?
   :specializer: <empty-list>

.. method:: null?
   :specializer: <object>

.. function:: pair-do

   :signature: pair-do (func lst #rest lists) => (false)

   :parameter func: An instance of :drm:`<function>`.
   :parameter lst: An instance of :drm:`<list>`.
   :parameter #rest lists: An instance of :drm:`<object>`.
   :value false: An instance of :drm:`<boolean>`.

.. function:: pair-foldl

   :signature: pair-foldl (cons nil lst) => (#rest results)

   :parameter cons: An instance of :drm:`<function>`.
   :parameter nil: An instance of :drm:`<object>`.
   :parameter lst: An instance of :drm:`<list>`.
   :value #rest results: An instance of :drm:`<object>`.

.. function:: pair-foldr

   :signature: pair-foldr (cons nil lst) => (#rest results)

   :parameter cons: An instance of :drm:`<function>`.
   :parameter nil: An instance of :drm:`<object>`.
   :parameter lst: An instance of :drm:`<list>`.
   :value #rest results: An instance of :drm:`<object>`.

.. generic-function:: pair?

   :signature: pair? (arg) => (#rest results)

   :parameter arg: An instance of :drm:`<object>`.
   :value #rest results: An instance of :drm:`<object>`.

.. method:: pair?
   :specializer: <pair>

.. method:: pair?
   :specializer: <object>

.. function:: partition

   :signature: partition (pred seq) => (winners losers)

   :parameter pred: An instance of :drm:`<function>`.
   :parameter seq: An instance of :drm:`<sequence>`.
   :value winners: An instance of :drm:`<list>`.
   :value losers: An instance of :drm:`<list>`.

.. macro:: pop!

.. generic-function:: precedes?

   :signature: precedes? (elt-1 elt-2 seq #key test not-found) => (precedes?)

   :parameter elt-1: An instance of :drm:`<object>`.
   :parameter elt-2: An instance of :drm:`<object>`.
   :parameter seq: An instance of :drm:`<sequence>`.
   :parameter #key test: An instance of :drm:`<object>`.
   :parameter #key not-found: An instance of :drm:`<object>`.
   :value precedes?: An instance of :drm:`<boolean>`.

.. macro:: push!

.. function:: reduce-l

   :signature: reduce-l (cons nil lst) => (#rest results)

   :parameter cons: An instance of :drm:`<function>`.
   :parameter nil: An instance of :drm:`<object>`.
   :parameter lst: An instance of :drm:`<list>`.
   :value #rest results: An instance of :drm:`<object>`.

.. function:: reduce-r

   :signature: reduce-r (cons nil lst) => (#rest results)

   :parameter cons: An instance of :drm:`<function>`.
   :parameter nil: An instance of :drm:`<object>`.
   :parameter lst: An instance of :drm:`<list>`.
   :value #rest results: An instance of :drm:`<object>`.

.. generic-function:: reverse-append
   :open:

   :signature: reverse-append (reversed-head tail) => (new-sequence)

   :parameter reversed-head: An instance of :drm:`<sequence>`.
   :parameter tail: An instance of :drm:`<sequence>`.
   :value new-sequence: An instance of :drm:`<sequence>`.

.. method:: reverse-append
   :specializer: <sequence>, <sequence>

.. method:: reverse-append
   :specializer: <list>, <list>

.. generic-function:: satisfies

   :signature: satisfies (pred seq #key failure) => (index)

   :parameter pred: An instance of :drm:`<function>`.
   :parameter seq: An instance of :drm:`<sequence>`.
   :parameter #key failure: An instance of :drm:`<object>`.
   :value index: An instance of :drm:`<object>`.

.. function:: tabulate

   :signature: tabulate (length func #key type) => (#rest results)

   :parameter length: An instance of :drm:`<integer>`.
   :parameter func: An instance of :drm:`<function>`.
   :parameter #key type: An instance of :drm:`<object>`.
   :value #rest results: An instance of :drm:`<object>`.

.. function:: tails

   :signature: tails (lists) => (#rest results)

   :parameter lists: An instance of :drm:`<list>`.
   :value #rest results: An instance of :drm:`<object>`.

.. generic-function:: take
   :open:

   :signature: take (collection k) => (#rest results)

   :parameter collection: An instance of :drm:`<object>`.
   :parameter k: An instance of :drm:`<integer>`.
   :value #rest results: An instance of :drm:`<object>`.

.. method:: take
   :specializer: <sequence>, <integer>

.. function:: unfold

   :signature: unfold (pred f g seed) => (new-list)

   :parameter pred: An instance of :drm:`<function>`.
   :parameter f: An instance of :drm:`<function>`.
   :parameter g: An instance of :drm:`<function>`.
   :parameter seed: An instance of :drm:`<object>`.
   :value new-list: An instance of :drm:`<list>`.

.. function:: unfold/tail

   :signature: unfold/tail (pred f g e seed) => (new-list)

   :parameter pred: An instance of :drm:`<function>`.
   :parameter f: An instance of :drm:`<function>`.
   :parameter g: An instance of :drm:`<function>`.
   :parameter e: An instance of :drm:`<function>`.
   :parameter seed: An instance of :drm:`<object>`.
   :value new-list: An instance of :drm:`<list>`.

.. function:: xpair

   :signature: xpair (list elt) => (new-list)

   :parameter list: An instance of :drm:`<list>`.
   :parameter elt: An instance of :drm:`<object>`.
   :value new-list: An instance of :drm:`<list>`.
