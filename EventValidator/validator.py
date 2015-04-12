from parse_rest.connection import register
from parse_rest.datatypes import Object
from datetime import timedelta

def time_diff(e1, e2):
	return abs(e1.createdAt - e2.createdAt)

# connect to parse and initialize object types
class Game(Object):
    pass

class Event(Object):
    pass
register("k6BA02wILh0LWU04kWB1CT6HidrHkcqKSB15QxTv", "lg985CdYU3sIaeui5M5AST3WTmRaTVodB0wSJUTS", master_key="zKomCssbmWbmiPAFIU5zsul4bZajoeqgmy3ytRxW")


def main():
	# get game and related events
	game = Game.Query.get(objectId="nIM6FMf7o5")
	events = Event.Query.filter(game=game).order_by("createdAt")

	# track if an event has already been clustered so we don't have to look at it again
	for e1 in events:
		e1.clustered = False

	valid_events = []

	# brute force n^2 version
	# greedy chronologically
	# an event is valid if there are at least 2 registered events
	# of the same type within 5 seconds, from at least 2 different people
	for e1 in events:
		if not e1.clustered:	
			cluster = [e1]
			for e2 in events:
                if e1.objectId != e2.objectId and e1.type == e2.type and not e2.clustered: # and e1.submittedBy != e2.submittedBy
                    # removed that constraint for testing
					if time_diff(e1,e2) <= timedelta(seconds=5.0):
						cluster.append(e2)
						e2.clustered = True

			if len(cluster) > 1:
				valid_events.append(cluster[0]) # mark the earliest as the ground truth


	for ve in valid_events:
		print "{} @ {}: Verified {} at time {}".format(game.teams[1], game.teams[0], ve.type, ve.createdAt)


if __name__ == "__main__":
	main()