import kenlm

model = kenlm.Model('test.arpa')

print(model.score('this is a sentence .', bos = True, eos = True))

state = kenlm.State()
state2 = kenlm.State()

model.BeginSentenceWrite(state)

accum = 0.0

accum += model.BaseScore(state, "a", state2)
accum += model.BaseScore(state2, "sentence", state)
#score defaults to bos = True and eos = True.  Here we'll check without the end
#of sentence marker.
assert (abs(accum - model.score("a sentence", eos = False)) < 1e-3)
accum += model.BaseScore(state, "</s>", state2)
assert (abs(accum - model.score("a sentence")) < 1e-3)