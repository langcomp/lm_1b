from scipy.special import logsumexp
from math import pow
import numpy as np

def perplexity(x):
	pplx = pow(10, (-1.0 * ((np.nansum(x) / len(~np.isnan(x))))))
	return pplx

def interpolate(lp1, lp2, b):
	# interpolates two log probabilities with mixing weight b
	return logsumexp([lp1, lp2], b = [b, 1 - b])

def interpolate_vectors(lstm_vec, ngram_vec, vec_w=0.71):
	# interp_vec = [interpolate(a, b, vec_w) for a,b in zip(lstm_vec, ngram_vec)]
	# return interp_vec
	# return ( logsumexp([lstm_vec, ngram_vec], vec_w))
	vectors_as_matrix = np.vstack((lstm_vec, ngram_vec))
	return (logsumexp(vectors_as_matrix, axis=0, b=np.repeat(np.array([[vec_w],[1 - vec_w]]),
															 vectors_as_matrix.shape[1], axis=1)))

def multiplicative_interpolate(lp1, lp2, b):
	return lp1*b + lp2*(1-b)
	
def multiplicative_interpolate_vectors(lstm_vec, ngram_vec, vec_w=0.71):
	# mult_interp_vec = [multiplicative_interpolate(a, b, vec_w) for a,b in zip(lstm_vec, ngram_vec)]
	# return mult_interp_vec
	# print(lstm_vec.shape, np.array([vec_w]).shape, ngram_vec.shape, np.array([(1 - vec_w)]).shape)
	return ( np.multiply(lstm_vec,np.array([vec_w])) + np.multiply(ngram_vec,np.array([(1 - vec_w)])))
