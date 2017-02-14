import sys, pygame
import random

'''
REACTION TIME CHECKER

The goal is to press 'r' as fast as possible if the picture is
a rectangle, and 'c' if the picture is a circle. 

'''

WIDTH = 600
HEIGHT = 600
fps = 100

BACKGROUND = (0,     0, 0)
RED        = (255,   0, 0)
BLUE       = (0  ,   0, 255)
GREEN      = (0  , 255, 0)

def drawFigure(screen, figure, posX, posY):
	'''
	Shows a figure (CIRCLE or RECTANGLE)
	at a given position on the screen.
	'''
	if figure == "CIRCLE":
		pygame.draw.circle(screen, RED, [posX,posY], 20)
	elif figure == "RECTANGLE":
		pygame.draw.rect(screen, GREEN, [posX,posY,20,20], 0)

def checkReaction(keyPressed, correctKey, startTime, timeUsed):
	if keyPressed == correctKey:
		score = 1
		message =  "Right"
	else:
		score = 0
		message =  "Wrong"

	time = timeUsed-startTime
	print "{0} key. Time: {1}".format(message, time)
	return [score, time]

def main(noSeconds=20, noReactions = 10,reactionLimit = 1):
	'''
	Must react within 1 second.
	'''
	pygame.init()
	screen = pygame.display.set_mode((WIDTH,HEIGHT))
	pygame.display.set_caption("Reaction speed test")
	clock = pygame.time.Clock()
	timeUsed = 0

	randomTimes = [t*noSeconds/float(noReactions) + random.random()*reactionLimit*0.5 for t in range(1,noReactions+1)]

	i = 0
	posX = random.randint(20, WIDTH-20)
	posY = random.randint(20, HEIGHT-20)
	randInt = random.randint(0,1)
	correctKey = [pygame.K_c,pygame.K_r][randInt]
	totalScore = 0
	totalTime = 0
	totalCorrectTime = 0
	screen.fill(BACKGROUND)
	draw = True
	running = True
	while running:
		for event in pygame.event.get():
			if event.type == pygame.QUIT:
				running = False
			elif event.type == pygame.KEYDOWN and event.key == pygame.K_ESCAPE:
				running = False
			if event.type == pygame.KEYDOWN:
				[score, time] = checkReaction(event.key, correctKey, randomTimes[i], timeUsed/float(1000))
				totalScore += score
				totalTime  += time
				totalCorrectTime += score*time

		if (timeUsed >= 1000*randomTimes[i]) and (timeUsed-1000*randomTimes[i] < 1000*reactionLimit):
			draw = True
			if randInt == 0:
				drawFigure(screen, "CIRCLE", posX, posY)
			else:
				drawFigure(screen, "RECTANGLE", posX, posY)
		elif timeUsed >= 1000*(randomTimes[i] + reactionLimit) and draw:
			posX = random.randint(0, WIDTH)
			posY = random.randint(0, HEIGHT)
			randInt = random.randint(0,1)
			correctKey = [pygame.K_c,pygame.K_r][randInt]
			i += 1
			screen.fill(BACKGROUND)
			draw = False

		if i == len(randomTimes):
			running = False

		pygame.display.update()
		timeUsed += clock.tick_busy_loop(fps)

	print "============"
	print "Total score: {0}".format(totalScore)
	print "Mean reaction time: {0}".format(totalTime/noReactions)
	if score > 0:
		print "Mean correct reaction time: {0}".format(totalCorrectTime/score)
	else:
		print "Mean correct reaction time: 0"

	pygame.quit()


if __name__ == '__main__':
	if len(sys.argv) == 1:
		main()
	else:
		try:
			noSec = int(sys.argv[1])
			noReac = int(sys.argv[2])
			main(noSeconds=noSec,noReactions=noReac,reactionLimit=1)
		except:
			print "Usage: "
	sys.exit()
