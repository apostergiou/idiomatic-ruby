# Enumerable and Enumerators

Let's suppose we have a collection of items such as a hash or an array. In order to iterate through the elements we usually use loop structures such as the `while` loop.
Ruby provides enumerators for this job and an Enumerable mixin. 

The `Enumerator` class implements methods we can use to iterate a collection and in addition the iteration can provide semantics about the iteration without exposing redundant logic.
