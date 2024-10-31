#!/usr/bin/env python3

import sys

import janus_swi as janus
from requests_html import HTMLSession


def fetch_puzzle(sid):
    session = HTMLSession()
    r = session.get(f"https://firestore.googleapis.com/v1/projects/oneup-cf4bb/databases/(default)/documents/puzzles/{sid}")
    return r.json()["fields"]["data"]["stringValue"]


def convert_puzzle_str(s):
    n = int(s[0])
    board = [[0] * n for _ in range(n)]
    
    walls_h = [[0] * (n+1) for _ in range(n+1)]
    walls_v = [[0] * (n+1) for _ in range(n+1)]

    # recover board
    for i, d in enumerate(s[1:n*n+1]):
        board[i // n][i % n] = int(d)

    # recover walls
    i, j = n*n+1, 0
    while i < len(s):
        r, c = j // (n+1), j % (n+1)

        walls_v[r][c] = int(s[i])
        walls_h[c][r] = int(s[i+1])

        i += 2
        j += 1

    walls_v = [r[1:] for r in walls_v][:-1]
    walls_h = [r[1:] for r in walls_h][:-1]

    return board, walls_h, walls_v


def solve_puzzle(board, walls_h, walls_v):
    janus.consult("solver")

    res = janus.query_once(f"""
    B = {str(board).replace('0', '_')},
    H = {str(walls_h)},
    V = {str(walls_v)},
    solveGrid(B, H, V).
    """)

    return res["B"]


if __name__ == "__main__":
    assert len(sys.argv) == 2, "Usage: oneup [puzzle key]"

    print("Fetching puzzle data...")
    try:
        puzzle = fetch_puzzle(sys.argv[1])
    except:
        print("Could not parse, find, or retrieve puzzle ID.")
        sys.exit(1)

    b, h, v = convert_puzzle_str(puzzle)

    print("\nBOARD:")
    for x in b: print(str(x).replace('0', '_'))

    print("\nSOLVED:")
    p = solve_puzzle(b, h, v)
    for x in p: print(x)
