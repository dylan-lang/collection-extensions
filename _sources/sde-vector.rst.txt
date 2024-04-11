The sde-vector Module
=====================

.. current-library:: collection-extensions
.. current-module:: sde-vector

Overview
--------

Stretchy double ended vector -- A collection that has keys from -n to n, where
n is a non-negative integer.  It's not technically a vector because the keys
don't start at 0, and so doesn't inherit a lot of sequence methods, but
otherwise it behaves like a vector.


Reference
---------

**TODO**: https://github.com/dylan-lang/collection-extensions/issues/2

.. class:: <sde-vector>

   :superclasses: :drm:`<mutable-collection>`, :drm:`<stretchy-collection>`

   :keyword fill: An instance of :drm:`<object>`.
   :keyword size: An instance of :drm:`<object>`.
