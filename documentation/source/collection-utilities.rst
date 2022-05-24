The collection-utilities Module
===============================

.. current-library:: collection-extensions
.. current-module:: collection-utilities

Reference
---------

**TODO**: These docs are just an auto-generated skeleton so
far. https://github.com/dylan-lang/collection-extensions/issues/2

.. generic-function:: key-exists?

   :signature: key-exists? (collection key) => (key-exists? value)

   :parameter collection: An instance of :drm:`<collection>`.
   :parameter key: An instance of :drm:`<object>`.
   :value key-exists?: An instance of :drm:`<boolean>`.
   :value value: An instance of :drm:`<object>`.

.. generic-function:: singleton?
   :open:

   :signature: singleton? (collection) => (singleton?)

   :parameter collection: An instance of :drm:`<collection>`.
   :value singleton?: An instance of :drm:`<boolean>`.

.. method:: singleton?
   :specializer: <collection>

.. method:: singleton?
   :specializer: <pair>

.. method:: singleton?
   :specializer: <empty-list>

