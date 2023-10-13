import Connect4Engine
import pygame as pg

# Create a screen
pg.init()
WIDTH = 700
HEIGHT = 600  # width and height of the frame
DIMENSION_HEIGHT = 6
DIMENSION_WIDTH = 7  # Dimensions of board 6x7
SQ_SIZE = HEIGHT // DIMENSION_HEIGHT  # Give the pixels per square
MAX_FPS = 15  # for animation later on
IMAGES = {}
BLUE = (0, 170, 255)
RED = (255, 51, 51)
YELLOW = (255, 204, 0)
PURPLE = (170, 0, 255)


def main():
    screen = pg.display.set_mode((WIDTH, HEIGHT))
    clock = pg.time.Clock()
    screen.fill(BLUE)
    gs = Connect4Engine.GameState()
    sqSelect = ()
    playerClicks = []
    running = True
    while running == True:
        for e in pg.event.get():
            if e.type == pg.QUIT:
                running = False
            if e.type == pg.MOUSEBUTTONDOWN:
                location = pg.mouse.get_pos()
                column = location[0] // SQ_SIZE
                row = location[1] // SQ_SIZE
                sqSelected = (row, column)
                # mapped for both 1st and 2nd clicks
                playerClicks.append(sqSelected)
                move = Connect4Engine.Move(
                    playerClicks[0], gs.board)
                validMove = gs.makeMove(move)
                if validMove:
                    result = gs.endGame(move)
                    if result == True:
                        # gs.reset()
                        pass
                sqSelect = ()
                playerClicks = []
        # KEY HANDLERS
            elif e.type == pg.KEYDOWN:
                if e.key == pg.K_z:
                    gs.undoMove()
                if e.key == pg.K_r:
                    gs.reset()
        draw_game_state(screen, gs.board)
        clock.tick(MAX_FPS)
        pg.display.flip()


def draw_game_state(screen, board):
    for c in range(DIMENSION_WIDTH):
        for r in range(DIMENSION_HEIGHT):
            if board[r][c] == "--":
                pg.draw.circle(screen, (0, 0, 0),
                               (c*SQ_SIZE+50, r*SQ_SIZE+50), 40)
            elif board[r][c] == "Y":
                pg.draw.circle(screen, YELLOW,
                               (c*SQ_SIZE+50, r*SQ_SIZE+50), 40)
            elif board[r][c] == "R":
                pg.draw.circle(screen, RED,
                               (c*SQ_SIZE+50, r*SQ_SIZE+50), 40)
            elif board[r][c] == "W":
                pg.draw.circle(screen, PURPLE,
                               (c*SQ_SIZE+50, r*SQ_SIZE+50), 40)


if __name__ == "__main__":
    main()
