## First step

Open a gitbash (MINGW64) on windows or terminal on linux or mac

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

| arg=$1          | arg=$2               | arg=$3 | arg=$4                                                                   | default <br> flags                                | type   | flags <br> alias                                                                   |
| --------------- | -------------------- | ------ | ------------------------------------------------------------------------ | ------------------------------------------------- | ------ | ---------------------------------------------------------------------------------- |
| g <br> generate | cl <br> class        | [name] |                                                                          | --type=class                                      | native |                                                                                    |
| g <br> generate | c <br> component     | [name] | **--prefix=$4**                                                          |                                                   | native | -e <br> -is <br> -it <br> -st <br> -sk <br> -e <br> -is <br> -it <br> -st <br> -sk |
| g <br> generate | P <br> page          | [name] | **--prefix=$4**                                                          | --type=page                                       | native | -e <br> -is <br> -it <br> -st <br> -sk <br> -e <br> -is <br> -it <br> -st <br> -sk |
| g <br> generate | d <br> directive     | [name] | **--prefix=$4**                                                          |                                                   | native | -e <br> -st <br> -sk <br> -e0 <br> -st0 <br> -sk0                                  |
| g <br> generate | e <br> enum          | [name] |                                                                          | --type=enum                                       | native |                                                                                    |
| g <br> generate | en <br> environments | [name] |                                                                          |                                                   | native |                                                                                    |
| g <br> generate | g <br> guard         | [name] |                                                                          | --functional=true                                 | native | -sk <br> -sk0                                                                      |
| g <br> generate | in <br> interceptor  | [name] |                                                                          | --functional=true                                 | native | -sk <br> -sk0                                                                      |
| g <br> generate | i <br> interface     | [name] |                                                                          | --type=interface                                  | native |                                                                                    |
| g <br> generate | t <br> type          | [name] | --implements='s1,s2,...,sn' [s : string \| number]                       | --type=type                                       | fake   |                                                                                    |
| g <br> generate | co <br> const        | [name] | --implements='p1:v1,p2:v2,...,pn:vn:' [p : string & v: string \| number] | --type=type                                       | fake   |                                                                                    |
| g <br> generate | m <br> module        | [name] |                                                                          |                                                   | native |                                                                                    |
| g <br> generate | mr <br> moduleroute  | [name] | **--module=$4**                                                          | --routing=true                                    | native |                                                                                    |
| g <br> generate | p <br> pipe          | [name] |                                                                          |                                                   | native | -e <br> -st <br> -sk <br> -e0 <br> -st0 <br> -sk0                                  |
| g <br> generate | r <br> resolver      | [name] |                                                                          | --functional=true                                 | native | -sk <br> -sk0                                                                      |
| g <br> generate | s <br> service       | [name] |                                                                          |                                                   | native | -sk <br> -sk0                                                                      |
| s <br> serve    | **--port=$2**        |        |                                                                          | --open                                            | native |                                                                                    |
| n <br> new      | [name]               |        |                                                                          | --style=scss <br> --routing=true <br> --ssr=false | native | -is <br> -it <br> -st <br> -sk <br> -is0 <br> -it0 <br> -st0 <br> -sk0             |

> [name] is a string

<br>
<br>
<br>

| where                | flag     | default value                              |
| -------------------- | -------- | ------------------------------------------ |
| generate component   | --prefix | root:app , shared:shared & modules:$module |
| generate page        | --prefix | root:app , shared:shared & modules:$module |
| generate directive   | --prefix | root:app , shared:shared & modules:$module |
| generate moduleroute | --module | app                                        |
| serve                | --port   | 4141                                       |

<br>
<br>
<br>

| flag alias | angular flag            |
| ---------- | ----------------------- |
| -e         | --export=true           |
| -is        | --inline-style=true     |
| -it        | --inline-template=true  |
| -st        | --standalone=true       |
| -sk        | --sk=true               |
| -e0        | --export=false          |
| -is0       | --inline-style=false    |
| -it0       | --inline-template=false |
| -st0       | --standalone=false      |
| -sk0       | --sk=false              |

<br>
<br>
<br>

### Examples

```bash
ngg n testing -sk -st0 -is0 -it0

ngg g mr modules/products

ngg g mr modules/articles modules/products

ngg g cl modules/products/product

ngg g c modules/products/listProducts product -is -it0 -sk

ngg g page modules/products/home product

ngg g m shared app

ngg g d shared/text shared -e -sk0

ngg g e shared/data

ngg g en

ngg g g isAdmin -sk

ngg g in iAmAnInterceptor

ngg g t shared/oneType

ngg g t shared/otherType "yes,no,may be,8,8.1,8.1.1"

ngg g co shared/userHuman "name:john,lastName:DOE,age:27,height:1.88"

ngg g p shared/dni -e

ngg g r data -sk0

ngg g s user -sk
```
