# vim: set fdm=marker fdc=2 :
# coding=utf-8

# imports {{{1
import vim
import re
from os import listdir, environ
from os.path import join, getmtime
from subprocess import Popen, PIPE

def get_changelist(query=None): # {{{1
	""" __get_changelist(query) -> changelog

	Returns a list of submitted changes
	"""
	command = ["p4", "changes", "-m", str(vim.eval("g:p4mon_num_changes"))]
	p4env = environ.copy()
	p4env['P4PORT'] = str(vim.eval("g:p4mon_port"))
	changes = [line for line
		in Popen(command, stdout=PIPE, stderr=PIPE, env=p4env).communicate()[0].\
			split("\n") if line != '']
	return changes

def fill_list(changes, queried=False, custom_order=False): # {{{1
	""" Writes the list of changes to the __p4mon__ buffer.

	changes: a list of changes to process.

	queried: whether files is the result of a query or not.

	custom_order: whether we should keep the order of the list given (implies queried=True).
	"""
	# we now show the list
	del vim.current.buffer[:] # clear the buffer
	vim.current.buffer.append(list(changes))
	vim.command("normal! dd")

def display(query): # {{{1
	""" Shows a list of changes

	query: ? maybe a filter on the branch? or user?

	Builds a list of changes
	"""
	p4_changes = get_changelist(query)
	if len(p4_changes) > 0:
		if vim.eval("bufexists('__p4mon__')") == "1":
			vim.command("bw __p4mon__")
		vim.command("silent! botright " + str(vim.eval("g:p4mon_window_height")) + "new __p4mon__")
		fill_list(p4_changes, query != "")
		vim.command("set filetype=p4mon")
		vim.command("setlocal nomodifiable")
	else:
		print "no changes"

def print_change():
	change_num = vim.current.line.split(" ")[1]
	command = ["p4", "describe", change_num]
	p4env = environ.copy()
	p4env['P4PORT'] = str(vim.eval("g:p4mon_port"))
	change_buffer = Popen(command, stdout=PIPE, stderr=PIPE, env=p4env).communicate()[0].split("\n");
	vim.command("silent! botright " + str(vim.eval("g:p4mon_window_height")) + " split change" + change_num)
	del vim.current.buffer[:] # clear the buffer
	vim.current.buffer.append(list(change_buffer))
	vim.command("normal! dd")
	vim.command("set filetype=diff")
	vim.command("setlocal nomodifiable")
	vim.command("noremap <silent> <buffer> <localleader><esc> :bd!<cr>")
