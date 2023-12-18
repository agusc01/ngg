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

| arg=$1          | arg=$2               | arg=$3 | arg=$4                                   | default <br> flags                                                                               | type   | flags <br> alias                       |
| --------------- | -------------------- | ------ | ---------------------------------------- | ------------------------------------------------------------------------------------------------ | ------ | -------------------------------------- |
| g <br> generate | cl <br> class        | [name] |                                          | --type=class                                                                                     | native |                                        |
| g <br> generate | c <br> component     | [name] | **--prefix=$4**                          |                                                                                                  | native | -e <br> -is <br> -it <br> -st <br> -sk |
| g <br> generate | P <br> page          | [name] | **--prefix=$4**                          | --type=page                                                                                      | native | -e <br> -is <br> -it <br> -st <br> -sk |
| g <br> generate | d <br> directive     | [name] | **--prefix=$4**                          |                                                                                                  | native | -e <br> -st <br> -sk                   |
| g <br> generate | e <br> enum          | [name] |                                          | --type=enum                                                                                      | native |                                        |
| g <br> generate | en <br> environments | [name] |                                          |                                                                                                  | native |                                        |
| g <br> generate | g <br> guard         | [name] |                                          | --functional=true                                                                                | native | -sk                                    |
| g <br> generate | in <br> interceptor  | [name] |                                          | --functional=true                                                                                | native | -sk                                    |
| g <br> generate | i <br> interface     | [name] |                                          | --type=interface                                                                                 | native |                                        |
| g <br> generate | t <br> type          | [name] | **implements=n1,n2,...,nn [n : string]** | --type=type                                                                                      | fake   |                                        |
| g <br> generate | m <br> module        | [name] |                                          |                                                                                                  | native |                                        |
| g <br> generate | mr <br> moduleroute  | [name] | **--module=$4**                          | --routing=true                                                                                   | native |                                        |
| g <br> generate | p <br> pipe          | [name] |                                          |                                                                                                  | native | -e <br> -st <br> -sk                   |
| g <br> generate | r <br> resolver      | [name] |                                          | --functional=true                                                                                | native | -sk                                    |
| g <br> generate | s <br> service       | [name] |                                          |                                                                                                  | native | -sk                                    |
| s <br> serve    | **--port=$2**        |        |                                          | --open                                                                                           | native |                                        |
| n <br> new      |                      |        |                                          | --skipt-test=true <br> --style=scss <br> --standalone=false <br> --routing=true <br> --ssr=false | native |                                        |

> [name] is a string

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

<br>
<br>
<br>

### Examples

```bash
ngg new ng-testing-ngg

ngg g mr modules/products

ngg g mr modules/articles modules/products

ngg g cl modules/products/classes/product

ngg g c modules/products/components/listProducts product -is -it -sk

ngg g page modules/products/pages/home product

ngg g m shared app

ngg g d shared/directives/text shared -e -sk

ngg g e shared/enums/data

ngg g en

ngg g g guards/isAdmin -sk

ngg g in interceptors/body

ngg g t shared/types/customType

ngg g t shared/types/grettings "hi,bye,hi there"

ngg g p shared/pipes/dni -e

ngg g r resolvers/data -sk

ngg g s services/user -sk
```
