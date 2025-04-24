extends Node

var is_amharic = false
var is_loading = false
var jokes = []
var JOKESQUANTITY = 5
var url = "https://dad-jokes-pypy.onrender.com/api/v1/get_jokes"
var player_score = 0
var life_count = 3

var approving_responses = ['Splendid jest, peseant!', 'Ha! That’s a good one!', 'Well done, you’ve amused me!', 'Ah, what a delightful jest!', 'Excellent! You’ve lightened my spirits!']
var disapproving_responses = ['That jest fell flat', 'Not amusing, try again.', 'That jest was not to my taste.', 'I didn’t find that funny.', 'Your humor missed the mark.']

func filter_jokes(jokes):
	var filtred_jokes: Array = []
	for joke in jokes:
		if !is_amharic and joke["language"] == "ENGLISH":
			filtred_jokes.append(joke)
		elif is_amharic and joke["language"] == "AMHARIC":
			filtred_jokes.append(joke)
	return filtred_jokes

func random_jokes(jokes):
	var selected_jokes = []
	
	for i in range(JOKESQUANTITY):
		selected_jokes.append(jokes[rand_range(0,jokes.size())])
	return selected_jokes
	
func remove_joke(joke):
	var updated_jokes = []
	for j in jokes:
		if j["id"] == joke["id"]:
			continue
		else:
			updated_jokes.append(j)
	jokes = updated_jokes

func is_funny(joke,jokes):
	if joke["rate"] > 5:
		
		return true
	else:
		return false
