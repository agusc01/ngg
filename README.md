# Settings for windows

> note: for linux and mac you just have to change the main root

## First step

Open a gitbash (MINGW64)

```bash
cd ~ && git clone https://github.com/agusc01/ngg
```

## Second step

```bash
add_ngg="if [ -f ~/ngg/script.sh ]; then
  . ~/ngg/script.sh
fi"

echo "$add_ngg" >> ~/.bashrc

source ~/.bashrc
```

## Third step

_enjoy!_

<br>
<br>
<br>

## Documentation (?)

| argument=$1   | argument=$2        | argument=$3     | argument=$4                              | default flags                                                                                    | type   | flags alias                    |
| ------------- | ------------------ | --------------- | ---------------------------------------- | ------------------------------------------------------------------------------------------------ | ------ | ------------------------------ |
| g <br> generate | cl <br> class        | [name : string] |                                          | --type=class                                                                                     | native |                                |
| g <br> generate | c <br> component     | [name : string] | **--prefix=$4**                          |                                                                                                  | native | -e <br> -is <br> -it <br> -st <br> -sk |
| g <br> generate | P <br> page          | [name : string] | **--prefix=$4**                          | --type=page                                                                                      | native | -e <br> -is <br> -it <br> -st <br> -sk |
| g <br> generate | d <br> directive     | [name : string] | **--prefix=$4**                          |                                                                                                  | native | -e <br> -st <br> -sk               |
| g <br> generate | e <br> enum          | [name : string] |                                          | --type=enum                                                                                      | native |                                |
| g <br> generate | en <br> environments | [name : string] |                                          |                                                                                                  | native |                                |
| g <br> generate | g <br> guard         | [name : string] |                                          | --functional=true                                                                                | native | -sk                            |
| g <br> generate | in <br> interceptor  | [name : string] |                                          | --functional=true                                                                                | native | -sk                            |
| g <br> generate | i <br> interface     | [name : string] |                                          | --type=interface                                                                                 | native |                                |
| g <br> generate | t <br> type          | [name : string] | **implements=n1,n2,...,nn [n : string]** | --type=type                                                                                      | fake   |                                |
| g <br> generate | m <br> module        | [name : string] |                                          |                                                                                                  | native |                                |
| g <br> generate | mr <br> moduleroute  | [name : string] | **--module=$4**                          | --routing=true                                                                                   | native |                                |
| g <br> generate | p <br> pipe          | [name : string] |                                          |                                                                                                  | native | -e <br> -st <br> -sk               |
| g <br> generate | r <br> resolver      | [name : string] |                                          | --functional=true                                                                                | native | -sk                            |
| g <br> generate | s <br> service       | [name : string] |                                          |                                                                                                  | native | -sk                            |
| s <br> serve    | **--port=$2**      |                 |                                          | --open                                                                                           | native |                                |
| n <br> new      |                    |                 |                                          | --skipt-test=true <br> --style=scss <br> --standalone=false <br> --routing=true <br> --ssr=false | native |                                |

<br>
<br>
<br>

| where                | flag     | default value |
| -------------------- | -------- | ------------- |
| generate component   | --prefix | app           |
| generate page        | --prefix | app           |
| generate directive   | --prefix | app           |
| generate moduleroute | --module | app           |
| serve                | --port   | 4141          |

<br>
<br>
<br>

| flag alias | angular flag           |
| ---------- | ---------------------- |
| -e         | --export=true          |
| -is        | --inline-style=true    |
| -it        | --inline-template=true |
| -st        | --standalone=true      |
| -sk        | --sk=true              |


# TODO: 

- [ ] ngg g type shared/types/grettings "hi,bye,hi there" -> accept spaces