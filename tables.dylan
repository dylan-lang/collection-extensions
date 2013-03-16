module: tables
author: Dustin Voss
synopsis: OD does not have a <case-insensitive-string-table>. This remedies that.
          Code is taken from GD, using a superclass of <table> instead of <value-table>.

define sealed class <case-insensitive-string-table> (<table>)
end class <case-insensitive-string-table>;

define sealed domain make(singleton(<case-insensitive-string-table>));
define sealed domain initialize(<case-insensitive-string-table>);

define sealed inline method table-protocol (ht :: <case-insensitive-string-table>)
 => (key-test :: <function>, key-hash :: <function>);
  values(case-insensitive-equal, case-insensitive-string-hash);
end method table-protocol;
