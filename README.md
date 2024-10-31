# oneup-solver

Solves the [One up puzzle](https://www.oneuppuzzle.com).

Uses Prolog to solve the puzzle and Python for a CLI interface.

## Installation

1. Install [SWI-Prolog](https://www.swi-prolog.org/download/stable) and Python
2. Install the prerequisites:

```bash
python -m pip install requests-html janus-swi
```

3. Clone this repo:

```bash
git clone https://github.com/blademaw/oneup-solver.git
```

## Usage

1. Find the current puzzle ID via the [One up puzzle website](https://www.oneuppuzzle.com). For example, today's ID was `f8fKWY05J7bB09dRu6sM`
2. Navigate to the install directory and run:

```bash
python -m oneup <ID>
```

### Example output

```bash
$ python -m oneup f8fKWY05J7bB09dRu6sM
```

```
Fetching puzzle data...

BOARD:
[_, 1, _, _, _, _, _]
[4, _, _, _, _, _, _]
[_, _, _, _, _, _, _]
[_, _, _, _, 6, _, _]
[2, _, _, _, _, _, _]
[_, 2, _, _, _, _, _]
[_, _, 5, _, _, 4, _]

SOLVED:
[5, 1, 4, 2, 3, 1, 2]
[4, 3, 2, 1, 2, 3, 1]
[1, 5, 6, 2, 4, 7, 3]
[3, 4, 7, 1, 6, 5, 2]
[2, 7, 1, 3, 5, 6, 4]
[1, 2, 3, 2, 1, 2, 1]
[2, 6, 5, 1, 7, 4, 3]
```
