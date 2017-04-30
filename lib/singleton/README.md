# Ruby Singleton Class

A demonstration about how to use Ruby singleton classes. It is important not
to confuse them with the singleton pattern.

Similar names in the community: singleton class - metaclass - eigenclass

## Notes

The `class << foo` syntax opens up foo's singleton class, so you can specify methods for a *particular object*. For example `class << self` opens up self's singleton class, so that methods can be defined for the current self object.
