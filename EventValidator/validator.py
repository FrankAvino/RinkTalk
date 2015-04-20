#!/usr/bin/python

from parse_rest.connection import register
from parse_rest.datatypes import Object
import datetime
import sys

def time_diff(e1, e2):
	return abs(e1.createdAt - e2.createdAt)

# TODO don't repeat this check a million times
def different_people(e1,e2):
	if hasattr(e1, 'submittedBy') and hasattr(e2, 'submittedBy'):
		return e1.submittedBy != e2.submittedBy

	if hasattr(e1, 'guestName') and hasattr(e2, 'guestName'):
		return e1.guestName != e2.guestName

	return True

# connect to parse and initialize object types
class Game(Object):
    pass

class Event(Object):
    pass


def main():
	if len(sys.argv) < 2:
		print "No game specified"
		return
	register("k6BA02wILh0LWU04kWB1CT6HidrHkcqKSB15QxTv", "lg985CdYU3sIaeui5M5AST3WTmRaTVodB0wSJUTS", master_key="zKomCssbmWbmiPAFIU5zsul4bZajoeqgmy3ytRxW")

	# get game and related events
	game = Game.Query.get(objectId=sys.argv[1])
	events = Event.Query.all().filter(game=game).order_by("createdAt").limit(1000)
	# TODO figure out a way to get ALL data, ignore limit

	unique_users = {}
	num_users = 0
	print "\n{} total events recorded for {} @ {}:\n======================".format(len(events),game.teams[1], game.teams[0])
	# track if an event has already been clustered so we don't have to look at it again
	for e1 in events:
		if hasattr(e1, 'submittedBy') and str(e1.submittedBy) not in unique_users:
			unique_users[str(e1.submittedBy)] = e1.submittedBy
			num_users += 1
		elif hasattr(e1, 'guestName') and e1.guestName not in unique_users:
			unique_users[e1.guestName] = e1.guestName
			num_users += 1

		print "{} @ {}".format(e1.type,e1.createdAt.strftime("%m-%d %H:%M:%S"))
		e1.clustered = False
	print "\n{} unique users recorded at least one event for this game.".format(num_users)


	num_clustered = 0
	valid_events = []
	confidence_map ={}

	# brute force n^2 version
	# greedy chronologically
	# an event is valid if there are at least 2 registered events
	# of the same type within 5 seconds, from at least 2 different people
	for e1 in events:
		if not e1.clustered:	
			cluster = [e1]
			for e2 in events:
				# and e1.submittedBy != e2.submittedBy
				# removed that constraint for testing
				if e1.objectId != e2.objectId and e1.type == e2.type and not e2.clustered and different_people(e1,e2):
					if time_diff(e1,e2) <= datetime.timedelta(seconds=5.0):
						cluster.append(e2)
						e2.clustered = True

			if len(cluster) > 1:
				num_clustered += len(cluster)
				if len(cluster) in confidence_map:
					confidence_map[len(cluster)] += 1
				else:
					confidence_map[len(cluster)] = 1
				valid_events.append((cluster[0], len(cluster))) # mark the earliest as the ground truth

	game_start = datetime.datetime(2015, 4, 18, 23, 58, 0)
	print "\nTossed out {} unconfirmed recordings.".format(len(events) - num_clustered)
	print "\nFound {} confirmed events for {} @ {}.\n==========================".format(len(valid_events),game.teams[1], game.teams[0])
	print "(Times relative to game start at {})\n".format(game_start)

	for ve in valid_events:
		# TODO for links in video, subtract all times by 5s to make it easier to watch?
		# TODO use cluster sizes as confidence measure
		print "{} @ {} (recorded by {} users)".format(ve[0].type, str(ve[0].createdAt-game_start).split('.')[0], ve[1])

	print "\nFrequency of cluster sizes for confirmed events:\n=========================="
	for sz in confidence_map:
		print "{} people : {} events".format(sz, confidence_map[sz])
	print "\n"
	

if __name__ == "__main__":
	main()