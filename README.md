csvawk
======

AWK for CSV files.

Description
-----------

I often have to work with CSV files. Things like extracting a set of
columns, or removing columns. AWK would be the perfect tool for this,
but the fact is it don't work well with CSV files.

It's perfect if the data is always enclosed or never enclosed, and the
delimiter is never used inside an enclosed data.

For example, these CSV files could work with AWK:

```
foo,bar,baz
a,b,c
```

```awk
BEGIN {
    FS = ","
}
```

```
"foo","bar","baz"
"a","b","c"
```

```awk
BEGIN {
    # The fields would be shifted right by one
    FS = "\",\"|^\"|\"$"
}
```

But there is no simple way to handle the following:

```
foo,"bar","baz"
"delimiter, in field","field on
multiple lines","enclosure ""in"" field"
```

That's why I created **csvawk**. This tool can handle every kind of CSV,
without wondering if every field is quoted, and checking that a field
can't contain the delimiter nor the enclosure.

Dependencies
------------

* `python3`
  * `docopt` <https://pypi.python.org/pypi/docopt/0.6.2>
* `awk`

Examples
--------

Executed on the previous example (that you can find in `test.csv`):

```sh
csvawk '{print $2, $3} test.csv'
```

```
bar,baz
"field on
multiple lines","enclosure ""in"" field"
```

In the AWK program, the fields are properly parsed; even if we double the
inner quotes in the CSV file to escape them, we can work on the raw field:

```sh
csvawk '{gsub(/"/, "*", $3); print $3}' test.csv
```

```
baz
enclosure *in* field
```
