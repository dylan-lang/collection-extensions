The sequence-diff Module
========================

.. current-library:: collection-extensions
.. current-module:: sequence-diff


Overview
--------

The sequence-diff module implements an algorithm that accomplishes something
similar to the Unix diff utility.  (Your actual diff utility may or may not use
this algorithm, but it does something similar.)

Algorithm is by Webb Miller and Eugene W. Myers, published as "A File
Comparison Program", p.  1025-1040 of Software--Practice and Experience,
November 1985.  Quite frankly the algorithm is rather incomprehensible in
source code form, so you might want to think about getting the paper.


Reference
---------

**TODO**: These docs are just an auto-generated skeleton so
far. https://github.com/dylan-lang/collection-extensions/issues/2

.. class:: <delete-entry>

   :superclasses: :class:`<script-entry>`


.. class:: <insert-entry>

   :superclasses: :class:`<script-entry>`

   :keyword required source-index: An instance of :drm:`<object>`.

.. class:: <script-entry>
   :abstract:

   :superclasses: :drm:`<object>`

   :keyword count: An instance of :drm:`<object>`.
   :keyword required dest-index: An instance of :drm:`<object>`.

.. generic-function:: dest-index

   :signature: dest-index (object) => (value)

   :parameter object: An instance of :class:`<script-entry>`.
   :value value: An instance of :drm:`<object>`.

.. generic-function:: element-count

   :signature: element-count (object) => (value)

   :parameter object: An instance of :class:`<script-entry>`.
   :value value: An instance of :drm:`<object>`.

.. generic-function:: sequence-diff

   :signature: sequence-diff (s1 s2) => (script)

   :parameter s1: An instance of :drm:`<sequence>`.
   :parameter s2: An instance of :drm:`<sequence>`.
   :value script: An instance of :const:`<script>`.

.. generic-function:: source-index

   :signature: source-index (object) => (value)

   :parameter object: An instance of :class:`<insert-entry>`.
   :value value: An instance of :drm:`<object>`.
