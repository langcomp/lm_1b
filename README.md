# Calculating word sequence probabilities from the lm_1b word model and aligning to eye gaze data


## Pre-Processing (`/create_probabilities_from_raw_data`):

[Note: Token counts may be slightly off due to filtering modifications.]

##### File Preparation

0) You should create a `/raw_data` directory to store the raw Dundee files (these must be acquired independently, as they are proprietary)

0) You should also create a directory that will be pointed to in `filenames.py` as the `google_lm_dir`. The `.pbtxt` and `ckpt` files from [tensorflow/models](https://github.com/tensorflow/models/tree/master/research/lm_1b) should be placed here.

1) `process_experiment.py` is the central file for processing. The file requires a (directory of) file(s) with raw corpus data. In the case of the Dundee corpus, these files are formatted as:
```
Are                                 1  1 1   1   1   ...  
tourists                            1  1 1   2   2   ...
enticed                             1  1 1   3   3   ...
```
The important element is that each line contains one token per line. Tokens should include punctuation, rather than having punctuationo on a separate line.

2) `create_text_token_files.create()` prints two files from the above directory of files:
    
    (a) `test_corpus.tkn` - A corpus file where each sentence is on a separate line. Punctuation is also surrounded by whitespaces, e.g. "exists . "
    
    (b) `test_token_line.tkn` - A corpus file with each token on a separate line. Again, punctuation constitutes a discrete token.

##### Create LSTM-based probabilities

1) The corpus file returned above is fed into `rnn_corpus.create()`. 

2) A `GoogleLanguageModel` is created. This relies on code and files from Tal Linzen's [rnn_agreement](https://github.com/TalLinzen/rnn_agreement/tree/master/rnnagr) codebase. The directory where these files are stored should be hardcoded into `filenames.py`. Also make sure that all dependencies listed in this repo are added to your current environment.

3) The RNN-LSTM is processed as follows:

    (a) `glm.process_init()` builds a new RNN, with `<S>` as the first word.
    
    (b) The transition probability of each new word occuring as the next state is calculated, and the LSTM state is updated.

    (c) When the sentence terminal `</s>` is encountered, a new LSTM is initiated with `<s>`.

    (d) `rnn_corpus.py` writes the output of the calculated probabilities to `rnn_probability_file`. Each line consists of:
    - Token file number
    - Token index
    - Token
    - Token probability 

4) Optionally, the `rnn_probability_file` can be fed into `perplexity.py`, which outputs the perplexity of the entire corpus given the probabilities of each token.

##### (Optional) Using `kenlm`

1) The count-based *n*-gram models are calculated using [`kenlm`](https://kheafield.com/code/kenlm/). In order to use `kenlm`'s output with the steps below, we use the following commands (Thank you to Marten van Schijndel for these):

    i) Create a binary file of the language model. This is in the format of a corpus arpa file.
    ```
    lmplz -o 5 -S 60G -T /tmp < 1-billion/lm_1b-raw-text.txt | build/bin/build_binary /dev/stdin lm1b-5gram.binary
    ```
    - adding `-T` helps speed up processing
    - The `raw-text.txt` file is a large text file from tensorflow with all of raw text, with punctuation whitespace delimited.
    - The last arguement is the outputted binary file.

    ii) Use the language model created in (i) to measure the (Dundee) corpus
    ```
    query lm1b-5gram.binary < dundee_corpus.tkn | python process_kenlm.py > output.txt
    ```
    - `dundee_corpus.tkn` is the file output from the model generation above, with one token per line, including punctuation as a separate token.
    - The processing file `process_kenlm.py` is adapted from [modelblocks](https://github.com/modelblocks/modelblocks-release). It takes the regular output of `kenlm` and puts it into a format appropriate for an R dataframe or similar format.

#### Align to Dundee corpus (`create_gaze_data.R`):

##### Align to token *types* in Dundee (~60,000)

0) The above steps should be run for the LSTM model, as well as a 5-, 4-, 3-, 2- and 1-gram language model. The results should all be put into a csv of the following format:
    ```csv
    FILE,WNUM,WORD,rnn_prob,kenlm5gram_prob,kenlm4gram_prob,kenlm3gram_prob,kenlm2gram_prob
    01,1,Are,-7.557139726,-3.3412342,-3.3412342,-3.3412342,-3.3412373
    01,2,tourists,-6.339384999,-4.647959,-4.647959,-4.582983,-4.7727933
    01,3,enticed,-5.600467538,-6.262744,-6.2964334,-6.231951,-6.517497
    ...
    01,10,?,-0.075328262,-2.691623,-2.58747,-2.7365475,-2.306135
    01,NA,</s>,-0.035893436,-0.16058159,-0.19427118,-0.055592526,-0.1109385

    ```
1) All alignment and subsequent exclusion is done in `create_gaze_data.R`. This creates proper alignment between lm_1b and dundee, to make the tokenization scheme alike. It then aligns all dundee data (for all 10 subjects) to the lm_1b and kenlm probabilities. 

    The alignment function requires the following files, from preprocessing (above):
    
    * `token_surprisal.csv` - Illustrated in Step 0 above, from preprocessing. The full Dundee corpus shoud have 60,916 tokens.
    * `lm1b-1gram.tsv` - This is essentially an occurence count. The full token list should have 2,425,339 tokens. This should be in a standard arpa format with headers:
        ```
        kenlm1gram.total.prob	WORD
        -8.92661	<unk>
        0	<s>
        -1.4210622	</s>
        -2.1811512	The
        -3.0964477	U.S.
        ```
    * `token.line`  - Should be generated from a csv formatted as, done in preprocessing:
        ```
        WORD,FILE,SCREEN,LINE.NUM,WORD.IN.LINE.NUM,word_id
        "Are",01,1,1,1,01_1
        "tourists",01,1,1,2,01_2
        "enticed",01,1,1,3,01_3
        ...
        "existence?",01,1,1,10,01_10
        ```
    * `masterTX.csv` - a concatenated file of all tx files used in `process_experiments.py` above. This was used for [Demberg & Keller (2008)](https://www.researchgate.net/publication/23394062_Data_from_eye-tracking_corpora_as_evidence_for_theories_of_syntactic_processing_complexity?enrichId=rgreq-db0b739c3b24839bc2c62de538155d0f-XXX&enrichSource=Y292ZXJQYWdlOzIzMzk0MDYyO0FTOjk5NTU4MjUyMDg5MzU4QDE0MDA3NDc5NDY5OTg%3D&el=1_x_3&_esc=publicationCoverPdf)

#### Components of alignment function
1) Interpolated models are added. The interpolation blend was taken from the optimal blend (lowest perplexity). The function to run this can also be found seperately in `evaluation_code/interpolate.R`.

2) The sentence terminal token `</s>` is removed. This is accomplished by `NA` for the line numbers. The sentence termina was not given a line number when processing lm_1b because it is noot in the Dundee corpus, and would throw off alignment. Once these are filtered ut, `token.surprisal` should have 58,528 tokens.

3) Since all probabilities thus far are in log space, we can sum the logprobs of the constituent tokens of a word to get the total logprob for a word. The 58k tokens should be reduced to 51,501 whole words in `word.surprisal.all`.

4) Unigram probabilities are added with a left join. If a word is not in the unigram probabilities, i.e. it is OOV, it will not find a match, and be filtered out. This includes words with punctuation. 

5) For every word, all of the previous word's information is added.

6) If the current word's previous word was non-alphabetic, then the current word is removed. This should result in 44,164 remaining words. If the current word is followed by a word with leading punctuation, this is also filtered out.

7) Add booleans for line edges are added to the token list

##### Align to every token instance (~436,000)

8) Filter out words with punctuation, leaving `dat.no.punct` with 372,371 tokens. 

9) Filter out words in Dundee that are not in lm_1b, leaving 319,333 tokens. Then filter out words for which the previous word was not in the lm_1b corpus. There should now be 37,420 unique tokens.

10) Filter out line beginnings and endings.

### Output

The align function above will create two data structures:
    
* `word.surprisal` - A unique row for each token
* `dat.no.punct` - A unique row for each instance of each token, for all subjects

## Creating models of data

Uless otherwise noted, the modeling files can all be run independently. There is not necessarily any order to run them in. The files are split up by what type of model they use, either GAMs or linear models.

#### GAMS
* `gams.R` - a large file that creates many different types of GAMs that are used below
* `ACL_GAMS.R` - unpublished GAM codes for uni-, bi-, trigrams both fitted and balanced
* `fitted_df_gams.R` - fitted df nonlinear GAMs and log likelihood tests
* `linear_fitted_df_gams.R` - fitted df linear GAMs
* `fixed_df_gams.R` - fixed df GAMS and log likelihood tests
* `gam_linearity.R` - unpublished tests for measuring how close a GAM is to a linear trend line, as a way to measure the GAM's linearity
* `gam_summary.R` - A scratchpad file for extracting summary data
* `gamm4_gams.R` - Experiment to see if we can use `gamm4` package instead of `mgcv`. Not very thoroughly developed.


#### Linear models
* `linear-models.R` - create a number of mixed effect models, with different random effects
* `anovas.R` - unpublished ANOVA code for comparing interpolated models
* `bigram-trigram-random-lin-models.R` - playing around with `stargazer` package for displaying different summaries of linear models with random effects
* `likelihood-ratio-tests.R` - uses `drop1` function to compare different LMs
* `lm-random-effects.R` - linear models with random effects for words, and removing random correlations
* `lm-iterative-emnlp.R` - chi-sq tests for EMNLP paper
* `unpubbed_lmer_models.R` - similar models to those published in CMCL and for EMNLP




## Creating visualizations from data
* `gam_plots.R` - (This does require precompiled GAM data structures, such as those from `fitted_df_gams.R`.) This created the GAM plots for the CMCL paper, using base R.
* `ll-lm.R` - plots for CMCL paper with delta log likelihood fr different language models
* `perplexity-plot.R` - unused perplexity plot
* `probability-densities.R` - unused file playing around with `dplyr` and `'melt`




## Miscellaneous files
 * `evaluation_code/bnc.R` - attempting the same filtering as Smith & Levy (2013) for British versus American spelling
 * `evaluation_code/perplexity.R` - for calculating perplexity of various LMs. This is referenced in `process_experiments.py`.
