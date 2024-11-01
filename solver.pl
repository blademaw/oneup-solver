:- use_module(library(clpfd)).

%% solveGrid(Grid, WallsH, WallsV)
%
% Given a puzzle Board, horizontal walls WallsH and vertical walls WallsV,
% solve the puzzle. WallsH and WallsV are from their respective perspectives:
% e.g., WallsH[i][j] tells you whether the j-th horizontal wall in the i-th
% column exists. WallsV[i][j] tells you whether the j-th vertical wall in the
% i-th row exists.
solveGrid(Board, WallsH, WallsV) :-
  % get rows
  parseSlots(Board, WallsV, Rows),
  
  % get columns
  transpose(Board, BoardT),
  parseSlots(BoardT, WallsH, Cols),

  % all row and column slots must have digits from 1..len
  maplist(length, Rows, RowLens),
  maplist(length, Cols, ColLens),
  maplist(slotsInRange, RowLens, Rows),
  maplist(slotsInRange, ColLens, Cols),

  % all numbers in row/col slots must be unique
  maplist(all_distinct, Rows),
  maplist(all_distinct, Cols),

  % label each unknown
  maplist(label, Board).


% helper function to maplist for CLP(FD)
slotsInRange(B, Arr) :- Arr ins 1..B.


%% parseSlots(Board, Walls, Slots)
%
% For a given Board and set of Walls (H/V), get the Slots, which are the groups
% of continuous cells (not separated by a wall) that must have digits
% 1..len(slot).
parseSlots(Board, Walls, Slots) :-
  parseSlotsAux(Board, Walls, [], Slots).


%% parseSlotsAux(Board, Walls, Acc, Slots)
%
% Accumulates slots in Acc to bind to Slots.
parseSlotsAux([], [], Slots, Slots).

parseSlotsAux([R|Rs], [W|Ws], SlotsAcc, Slots) :-
  parseSingleSlots(R, W, [], [], RSlots),
  append(SlotsAcc, RSlots, NewAcc),
  parseSlotsAux(Rs, Ws, NewAcc, Slots).


%% parseSingleSlots(Cells, Walls, CurSlot, Acc, Slots)
%
% For a given row/col of cells, parse the slots. The current slot is held by
% CurSlot and slots are accumulated by Acc.

% base case: no more cells to parse
parseSingleSlots([], _, CurSlot, Acc, RSlots) :-
  % if we have an un-committed slot, need to finalise
  ( CurSlot = [] ->
    RSlots = Acc
  ; RSlots = [CurSlot|Acc]
  ).

% recursive case: cell(s) to parse
parseSingleSlots([C|Cs], [W|Ws], CurSlot, Acc, RSlots) :-
  % add the current cell value to the slot
  NewSlot = [C|CurSlot],

  % if the next wall exists, finalise this slot and flush
  ( W =:= 1 ->
    NewAcc = [NewSlot|Acc],
    NextSlot = []
  ; NewAcc = Acc,
    NextSlot = NewSlot
  ),

  parseSingleSlots(Cs, Ws, NextSlot, NewAcc, RSlots).

