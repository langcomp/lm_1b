# python calcngramprobtoks.kenlm.py --fwprobs genmodel/fw.5.probs.tmp [--uprobs genmodel/fw.1.probs.tmp] [--bwprobs genmodel/bw.5.probs.tmp] > $@

# from __future__ import division
import re
import sys

# OPTS = {}
# for aix in range(1, len(sys.argv)):
#     if len(sys.argv[aix]) < 2 or sys.argv[aix][:2] != '--':
#         # filename or malformed arg
#         continue
#     elif aix < len(sys.argv) - 1 and len(sys.argv[aix + 1]) > 2 and sys.argv[aix + 1][:2] == '--':
#         # missing filename
#         continue
#     OPTS[sys.argv[aix][2:]] = sys.argv[aix + 1]

reEndfile = re.compile('^Perplexity')


def process_kenlines(kenlist):
    outlist = []
    sentpos = 1
    sentid = 0
    sentbegin = True
    for line in kenlist:
        sline = line.strip().split('\t')
        if reEndfile.match(line) and len(sline) == 2:
            # All that's left in the file is perplexity and OOV reports, so print and move on
            print(line)
            break
        for word in sline:
            sword = word.split()
            if sword[0] == "Total:":
                # end of sentence
                outlist[-1][3] = 1  # mark end of sentence
                sentbegin = True
                sentpos = 1
                sentid += 1
                # leave before the OOV report for the sentence
                break
            else:
                outlist.append([sword[0].split('=')[0], sword[-1], int(sentbegin), 0, sentpos, sentid])
                if sentbegin:
                    outlist[-1][2] = 1
                sentbegin = False
                sentpos += 1
    return (outlist)


# if OPTS['fwprobs'] == '-':
with sys.stdin as f:
    fwlines = process_kenlines(f.readlines())
# else:
#     with open(OPTS['fwprobs'], 'r') as f:
#         fwlines = process_kenlines(f.readlines())

# if 'uprobs' in OPTS:
#     with open(OPTS['uprobs'], 'r') as f:
#         ulines = process_kenlines(f.readlines())

# if 'bwprobs' in OPTS:
#     with open(OPTS['bwprobs'], 'r') as f:
#         bwlines = process_kenlines(f.readlines())

corpus = []
for ix in range(0, len(fwlines)):
    corpus.append(
        {'word': fwlines[ix][0], 'uprob': 0.0, 'fwprob': fwlines[ix][1], 'bwprob': 0.0, 'sentpos': fwlines[ix][4],
         'startofsentence': fwlines[ix][2], 'endofsentence': fwlines[ix][3], 'sentid': fwlines[ix][5]})
    # if 'uprobs' in OPTS:
    #     corpus[-1].update({'uprob': ulines[ix][1]})
    # if 'bwprobs' in OPTS:
    #     corpus[-1].update({'bwprob': bwlines[ix][1]})

#########################
#
# Output Compiled Data
#
#########################

header = ['sentpos', 'sentid', 'word', 'fwprob', 'startofsentence', 'endofsentence']

sys.stderr.write('Writing output\n')

sys.stdout.write(' '.join(header) + '\n')

for w in corpus:
    # output ngrams
    sys.stdout.write(' '.join(str(w[heading]) for heading in header) + '\n')  # outputs stats