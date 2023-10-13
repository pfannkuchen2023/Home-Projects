import numpy as np


class GameState():
    def __init__(self):
        self.board = np.array([["--", "--", "--", "--", "--", "--", "--"],
                               ["--", "--", "--", "--", "--", "--", "--"],
                               ["--", "--", "--", "--", "--", "--", "--"],
                               ["--", "--", "--", "--", "--", "--", "--"],
                               ["--", "--", "--", "--", "--", "--", "--"],
                               ["--", "--", "--", "--", "--", "--", "--"],
                               ])
        # Keep track of whose turn it is
        self.isYellowsTurn = True
        self.moveLog = []

    def makeMove(self, move):
        # Validity check
        if move.currentRow != 5:
            if (self.board[move.currentRow][move.currentColumn] == "--") and (self.board[move.currentRow + 1][move.currentColumn] != "--"):
                if self.isYellowsTurn == True:
                    self.board[move.currentRow][move.currentColumn] = "Y"
                else:
                    self.board[move.currentRow][move.currentColumn] = "R"
                # Assume move valid at the moment
                self.moveLog.append(move)  # so we can edit it later
                self.isYellowsTurn = not self.isYellowsTurn  # swap players
                return True
            else:
                print("Invalid move")
                return False
        else:
            if (self.board[move.currentRow][move.currentColumn] == "--"):
                if self.isYellowsTurn == True:
                    self.board[move.currentRow][move.currentColumn] = "Y"
                else:
                    self.board[move.currentRow][move.currentColumn] = "R"
                # Assume move valid at the mom ent
                self.moveLog.append(move)  # so we can edit it later
                self.isYellowsTurn = not self.isYellowsTurn  # swap players
                return True
            else:
                return False

    def undoMove(self):
        if len(self.moveLog) != 0:
            move = self.moveLog.pop()
            self.board[move.currentRow][move.currentColumn] = "--"
            self.isYellowsTurn = not self.isYellowsTurn
        print(self.board)

    def reset(self):
        self.moveLog = []
        self.isYellowTurn = True
        for i in range(6):
            for j in range(7):
                self.board[i][j] = "--"

    def endGame(self, move):
        placed = self.board[move.currentRow][move.currentColumn]
        # Is the board filled up
        if (self.board == "B").all() == True:
            return False
        # Check going horizontals
        else:
            maxRow = 5
            maxCol = 6
            posY = move.currentRow
            posX = move.currentColumn
            placed = self.board[posY][posX]
            # Vertical check
            # Create an array to check through
            for i in range(-4, 4):
                if ((posY+i) <= maxRow-3) and ((posY+i) >= 0):
                    if (self.board[i+posY][posX] == placed) and (self.board[i+1+posY][posX] == placed) and (self.board[i+2+posY][posX] == placed) and (self.board[i+3+posY][posX] == placed):
                        print("vert win")
                        self.board[posY+i][posX] = "W"
                        self.board[posY+i+1][posX] = "W"
                        self.board[posY+i+2][posX] = "W"
                        self.board[posY+i+3][posX] = "W"
                        return True
            # Horizontal check
            for i in range(-4, 4):
                if ((posX+i) <= maxCol-3) and ((posX+i) >= 0):
                    if (self.board[posY][posX+i] == placed) and (self.board[posY][posX+(1+i)] == placed) and (self.board[posY][posX+(i+2)] == placed) and (self.board[posY][posX+(i+3)] == placed):
                        print("horz win")
                        self.board[posY][posX+i] = "W"
                        self.board[posY][posX+(1+i)] = "W"
                        self.board[posY][posX+(i+2)] = "W"
                        self.board[posY][posX+(i+3)] = "W"
                        return True
            # Diagonal left
            for i in range(-4, 4):
                if ((posY+i) <= maxRow-3) and ((posY+i) >= 0) and ((posX+i) <= maxCol-3) and ((posX+i) >= 0):
                    if (self.board[posY+i][posX+i] == placed) and (self.board[posY+i+1][posX+(1+i)] == placed) and (self.board[posY+i+2][posX+(i+2)] == placed) and (self.board[posY+i+3][posX+(i+3)] == placed):
                        print("diag left win")
                        self.board[posY+i][posX+i] = "W"
                        self.board[posY+i+1][posX+(1+i)] = "W"
                        self.board[posY+i+2][posX+(i+2)] = "W"
                        self.board[posY+i+3][posX+(i+3)] = "W"

                        return True
            # Diagonal Right
            for i in range(-4, 4):
                if ((posY+i) <= maxRow-3) and ((posY+i) >= 0) and ((posX-i) <= maxCol-3) and ((posX-i) >= 0):
                    if (self.board[posY+i][posX-i] == placed) and (self.board[posY+i+1][posX-(1+i)] == placed) and (self.board[posY+i+2][posX-(i+2)] == placed) and (self.board[posY+i+3][posX-(i+3)] == placed):
                        print("diag right win")
                        self.board[posY+i][posX+i] = "W"
                        self.board[posY+i+1][posX-(1+i)] = "W"
                        self.board[posY+i+2][posX-(i+2)] = "W"
                        self.board[posY+i+3][posX-(i+3)] = "W"
                        return True
            return False


class Move():
    # Instead of using index rows and columns, we shall use rows and ranks
    def __init__(self, startSq, board):
        self.currentRow = startSq[0]
        self.currentColumn = startSq[1]
        self.placeMoved = board[self.currentRow][self.currentColumn]
