Profiling Bash Scripts For Fun and Profit
==========================================

Bash slow? Not any more!

## Usage

```
./profile.sh your_script separator
```

`separator` is a character that you are sure doesn't appear in your bash script (e.g '%%%')

the script will use this character as a separator in the output table

## Example

```
$ ./profile.sh examples/example.sh '%%%'

total_time=2.618%%%file=examples/example.sh%%%lineno=5%%%cmd=sleep 0.2
total_time=1.048%%%file=examples/other_script.sh%%%lineno=2%%%cmd=sleep 1
total_time=0.559%%%file=examples/example.sh%%%lineno=4%%%cmd=sleep 0.5
total_time=0.276%%%file=examples/example.sh%%%lineno=5%%%cmd=for i in
total_time=0.042%%%file=examples/example.sh%%%lineno=5%%%cmd=seq 1 10
total_time=0.028%%%file=examples/example.sh%%%lineno=6%%%cmd=my_func
total_time=0.026%%%file=examples/example.sh%%%lineno=2%%%cmd=dirname -- "
total_time=0.02%%%file=examples/other_script.sh%%%lineno=1%%%cmd=my_func
total_time=0.016%%%file=examples/example.sh%%%lineno=2%%%cmd=pwd
total_time=0.015%%%file=examples/example.sh%%%lineno=2%%%cmd=SCRIPT_DIR=
total_time=0.014%%%file=examples/example.sh%%%lineno=3%%%cmd=.
total_time=0.014%%%file=examples/example.sh%%%lineno=2%%%cmd=cd -- "
```
