The subseq Module
=================

.. current-library:: collection-extensions
.. current-module:: subseq

Overview
--------

:class:`<subsequence>` is a new subclass of :drm:`<sequence>`.  A subsequence
represents an aliased reference to some part of an existing sequence.  Although
they may be created by :drm:`make` (with required keywords ``source:``,
``start:`` and ``end:``) on one of the instantiable subclasses, they are more
often created by calls of the form

.. code-block:: dylan

   subsequence(sequence, start: 0, end: 3)

where ``start:`` and ``end:`` are optional keywords which default to the
beginning and end, respectively, of the source sequence.  No other new
operations are defined for subsequences, since all necessary operations are
inherited from :drm:`<sequence>`.

Because subsequences are aliased references into other sequences, several
properties must be remembered:

1. The contents of a subsequence are undefined after any destructive operation
   upon the source sequence.

2. Destructive operations upon subsequences may be reflected in the source.
   The results of reverse! and sort! should be expected to affect the source
   sequence for vector subsequences.

If the source sequences are instances of :drm:`<vector>` or :drm:`<string>`,
then the implementation will use subclasses of :class:`<subsequence>` which are
also subclasses of :drm:`<vector>` or :drm:`<string>`.

Efficiency notes:

1. The implementation tries to insure that subsequences of subsequences
   can be accessed as efficiently as the original subsequence.  (For
   example, the result of

   .. code-block:: dylan

      subsequence(subsequence(source, start: 1), start: 2)

   would produce a subsequence identical to the one produced by

   .. code-block:: dylan

      subsequence(source, start: 3)

2. Vector subsequences, like all other vectors, implement constant time element
   access.

3. Non-vector subsequences may take non-constant time to create, but will
   provide constant-time access to the first element.  This should produce the
   best performance provided some element of the subsequence is accessed at
   least once.


Reference
---------

.. class:: <byte-vector-subsequence>

   :superclasses: :class:`<vector-subsequence>`


.. class:: <subsequence>
   :abstract:

   :superclasses: :drm:`<sequence>`

   :keyword required end: An instance of :drm:`<integer>`.
   :keyword required source: An instance of :drm:`<sequence>`.
   :keyword required start: An instance of :drm:`<integer>`.

.. generic-function:: subsequence

   :signature: subsequence (seq) => (#rest results)

   :parameter seq: An instance of :drm:`<object>`.
   :value #rest results: An instance of :drm:`<object>`.

.. method:: subsequence
   :specializer: <subsequence>

.. method:: subsequence
   :specializer: <sequence>

.. method:: subsequence
   :specializer: <generic-subsequence>

.. method:: subsequence
   :specializer: <vector>

.. method:: subsequence
   :specializer: <byte-vector>

.. method:: subsequence
   :specializer: <byte-vector-subsequence>

.. method:: subsequence
   :specializer: <string>

