# malloc-stats

Small LD_PRELOAD library to show allocation stats

## Build

```
$ make
```

## Usage

```
$ LD_PRELOAD=/path/to/malloc-stats.so your-binary args...
```

## Interpretting the results

Sample usage:
```
$ LD_PRELOAD=~/malloc-stats/malloc-stats.so build/util/hb-shape Gulzar-Regular.ttf -u 660 --no-glyph-names
[1154=0+310]
          TOTAL                MALLOC              REALLOC
     num        size      num        size      num        size
       1           5        1           5        0           0 /lib64/libc.so.6(+0x39b71) [0x7efd91744b71]
       1           8        1           8        0           0 /home/behdad/harfbuzz/build/util/../src/libharfbuzz.so.0(hb_ot_layout_has_glyph_classes+0xe0) [0x7efd91ba4380]
       1          12        1          12        0           0 /home/behdad/harfbuzz/build/util/../src/libharfbuzz.so.0(+0x29b6c) [0x7efd91b4eb6c]
...
      18       3,328        0           0       18       3,328 /lib64/libglib-2.0.so.0(g_realloc+0x30) [0x7efd91a27720]
      23       4,692       23       4,692        0           0 /lib64/libglib-2.0.so.0(g_malloc0+0x21) [0x7efd91a275f1]
      31      13,872       31      13,872        0           0 /home/behdad/harfbuzz/build/util/../src/libharfbuzz.so.0(+0xabd1d) [0x7efd91bd0d1d]
      37     229,216       37     229,216        0           0 /home/behdad/harfbuzz/build/util/../src/libharfbuzz.so.0(+0xab352) [0x7efd91bd0352]
      40      21,655       40      21,655        0           0 /lib64/libglib-2.0.so.0(g_malloc+0x19) [0x7efd91a27169]
     243     294,351      203     282,076       40      12,275 (total)
```

Now, if we want to know where the allocation callsite `home/behdad/harfbuzz/build/util/../src/libharfbuzz.so.0(+0xab352)` is, we can use the `addr2line` tool:
```
$ addr2line -i -e /home/behdad/harfbuzz/build/util/../src/libharfbuzz.so +0xab352
/home/behdad/harfbuzz/build/../src/OT/Layout/GPOS/../../../hb-ot-layout-gsubgpos.hh:4047
/home/behdad/harfbuzz/build/../src/OT/Layout/GPOS/../../../hb-ot-layout-gsubgpos.hh:4502
/home/behdad/harfbuzz/build/../src/hb-ot-layout.cc:1965
```
