# First step

Open a gitbash (MINGW64) or terminal

```bash
cd ~ && git clone https://github.com/agusc01/ngg
```

# Second step

```bash
add_ngg="if [ -f ~/ngg/script.sh ]; then
  . ~/ngg/script.sh
fi"

echo "$add_ngg" >> .bashrc
```

# Third step

_enjoy!_

<br>
<br>
<br>

## Documentation (?)

| argument=$1   | argument=$2        | argument=$3     | argument=$4                              | default flags                                                                                    | type   | flags alias                    |
| ------------- | ------------------ | --------------- | ---------------------------------------- | ------------------------------------------------------------------------------------------------ | ------ | ------------------------------ |
| g \| generate | cl \| class        | [name : string] |                                          | --type=class                                                                                     | native |                                |
| g \| generate | c \| component     | [name : string] | **--prefix=$4**                          |                                                                                                  | native | -e \| -is \| -it \| -st \| -sk |
| g \| generate | P \| page          | [name : string] | **--prefix=$4**                          | --type=page                                                                                      | native | -e \| -is \| -it \| -st \| -sk |
| g \| generate | d \| directive     | [name : string] | **--prefix=$4**                          |                                                                                                  | native | -e \| -st \| -sk               |
| g \| generate | e \| enum          | [name : string] |                                          | --type=enum                                                                                      | native |                                |
| g \| generate | en \| environments | [name : string] |                                          |                                                                                                  | native |                                |
| g \| generate | g \| guard         | [name : string] |                                          | --functional=true                                                                                | native | -sk                            |
| g \| generate | in \| interceptor  | [name : string] |                                          | --functional=true                                                                                | native | -sk                            |
| g \| generate | i \| interface     | [name : string] |                                          | --type=interface                                                                                 | native |                                |
| g \| generate | t \| type          | [name : string] | **implements=n1,n2,...,nn [n : string]** | --type=type                                                                                      | fake   |                                |
| g \| generate | m \| module        | [name : string] |                                          |                                                                                                  | native |                                |
| g \| generate | mr \| moduleroute  | [name : string] | **--module=$4**                          | --routing=true                                                                                   | native |                                |
| g \| generate | p \| pipe          | [name : string] |                                          |                                                                                                  | native | -e \| -st \| -sk               |
| g \| generate | r \| resolver      | [name : string] |                                          | --functional=true                                                                                | native | -sk                            |
| g \| generate | s \| service       | [name : string] |                                          |                                                                                                  | native | -sk                            |
| s \| serve    | **--port=$2**      |                 |                                          | --open                                                                                           | native |                                |
| n \| new      |                    |                 |                                          | --skipt-test=true <br> --style=scss <br> --standalone=false <br> --routing=true <br> --ssr=false | native |                                |

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
