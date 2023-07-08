Profiling Bash Scripts For Fun and Profit
==========================================

Bash slow? Not any more!

## Usage

### Line Profiler

```
# move into the directory of your script
./line-profile.sh your_script separator [script args]
```

`separator` is a character that you are sure doesn't appear in your bash script (e.g '%%%')

the script will use this character as a separator in the output table

#### Example

```
$ cd examples
$ ../line-profile.sh example.sh ,
2.054,example.sh,4,sleep 0.2
1.005,other_script.sh,2,sleep 1
0.507,example.sh,3,sleep 0.5
0.03,example.sh,4,for i in
0.007,example.sh,4,seq 1 10
0.003,example.sh,5,my_func
0.003,example.sh,2,. other_script.sh
0.002,other_script.sh,1,my_func
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
main,1.132,
func2,0.821,0.512
func1,0.62,0.62
```
