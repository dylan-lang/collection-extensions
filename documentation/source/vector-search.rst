The vector-search Module
========================

.. current-library:: collection-extensions
.. current-module:: vector-search

Overview
--------

The *vector-search* module provides basic search and replace capabilities upon
restricted subsets of :drm:`<sequence>` -- primarily :drm:`<vector>`.
Exploiting the known properties of these types yields substantially better
performance than can be achieved for sequences in general.

Reference
---------

.. generic-function:: find-first-key

   :signature: find-first-key (seq pred? #key start end failure) => (#rest results)

   :parameter seq: An instance of :class:`<vector>`.
   :parameter pred?: An instance of :class:`<function>`.
   :parameter #key start: An instance of :class:`<object>`.
   :parameter #key end: An instance of :class:`<object>`.
   :parameter #key failure: An instance of :class:`<object>`.
   :value #rest results: An instance of :class:`<object>`.

   :discussion:

     Find the index of the first element (after ``start`` but before ``end``)
     of a vector which satisfies the given predicate.  If no matching element
     is found, return the ``failure`` value.  The defaults for start, end and
     failure are, respectively, 0, size(vector), and #f.  This function is like
     :drm:`find-key`, but accepts ``start:`` and ``end:`` rather than
     ``skip:``.


.. generic-function:: find-last-key

   :signature: find-last-key (seq pred? #key start end failure) => (#rest results)

   :parameter seq: An instance of :class:`<vector>`.
   :parameter pred?: An instance of :class:`<function>`.
   :parameter #key start: An instance of :class:`<object>`.
   :parameter #key end: An instance of :class:`<object>`.
   :parameter #key failure: An instance of :class:`<object>`.
   :value #rest results: An instance of :class:`<object>`.
