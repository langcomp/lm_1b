import os.path as op

root = '/Users/adamg/Dropbox/Northwestern/LangCompLab/Surprisal/lm_1b'
external_root = '/Users/adamg/OneDrive'

data_dir = op.join(root, 'raw_data')
preproc_dir = op.join(root, 'preprocessed_data')
dundee_dir = op.join(root, 'raw_data/raw_dundee_english/tx*.dat')
google_lm_dir = op.join(external_root, 'tf_data')


# parsed_wiki = op.join(data_dir, 'wikipedia.wcase.nodups.parsed.fixed.gz')
# parsed_wiki_subset = op.join(data_dir, 'wikipedia.parsed.subset.50.gz')
# vocab_file = op.join(data_dir, 'wiki.vocab')
# deps = op.join(data_dir, 'agr_50_mostcommon_10K.tsv')
# figures = op.join(root, 'writeups', 'figures')
# overall_report = op.join(data_dir, 'overall_report.csv')

