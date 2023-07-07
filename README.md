Profiling Bash Scripts For Fun and Profit
==========================================

Bash slow? Not any more!

## Usage

### Line Profiler

```
# move into the directory of your script
./profile.sh your_script separator [script args]
```

`separator` is a character that you are sure doesn't appear in your bash script (e.g '%%%')

the script will use this character as a separator in the output table

#### Example

```
$ cd examples
$ ../profile.sh example.sh ','

total_time=2.499,file=example.sh,lineno=4,cmd=sleep 0.2
total_time=1.049,file=other_script.sh,lineno=2,cmd=sleep 1
total_time=0.543,file=example.sh,lineno=3,cmd=sleep 0.5
total_time=0.156,file=example.sh,lineno=4,cmd=for i in 
total_time=0.026,file=example.sh,lineno=4,cmd=seq 1 10
total_time=0.016,file=example.sh,lineno=5,cmd=my_func
total_time=0.015,file=example.sh,lineno=2,cmd=. other_script.sh
total_time=0.014,file=other_script.sh,lineno=1,cmd=my_func
```

### Func Profiler

```
# move into the directory of your script
./func-profile.sh your_script 
```

the script will use the character "," as a separator

#### Example

```
$ cd examples
$ ../func-profile.sh func_example.sh

total_time=0.617,file=func_example.sh,funcname=func1
total_time=0.512,file=func_example.sh,funcname=func2
```
