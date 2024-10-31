largeBoard(B, H, V) :-
  B = [
  [_, 1, _, _, _, _, _],
  [4, _, _, _, _, _, _],
  [_, _, _, _, _, _, _],
  [_, _, _, _, 6, _, _],
  [2, _, _, _, _, _, _],
  [_, 2, _, _, _, _, _],
  [_, _, 5, _, _, 4, _]
  ],
  H = [
  [0, 0, 0, 0, 1, 0, 0],
  [0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0],
  [0, 1, 0, 1, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0],
  [0, 0, 1, 0, 0, 0, 0]
  ],
  V = [
  [0, 0, 0, 0, 1, 0, 0],
  [0, 0, 0, 1, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0],
  [0, 0, 1, 0, 1, 0, 0],
  [0, 0, 0, 0, 0, 0, 0]
  ].


smallBoard(Board, WallsH, WallsV) :-
  Board = [
  [_, _, _, _],
  [_, _, _, _],
  [_, _, _, _],
  [_, 1, _, _]
  ],
  WallsH = [
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [0, 1, 0, 0],
  [1, 0, 0, 0]
  ],
  WallsV = [
  [0, 0, 0, 0],
  [0, 1, 0, 0],
  [0, 0, 0, 0],
  [0, 0, 1, 0]
  ].

