import os
import vim
import time

zkdelimiter=vim.eval('g:zetteltag')
zkdir=vim.eval('g:zetteldir')
zkfiletype=vim.eval('g:zettelfiletype')
# print(fact)
# print('Zettelkasten loaded')

def createzettel(where,how):
    hor=time.strftime('%Y%m%d%H%M')
    name_file=zkdir+"/"+ hor+'-'+where+'.'+zkfiletype
    if how=='new':
        vim.command('edit '+name_file)
    elif how=='split':
        vim.command('split '+name_file)
    elif how=='vsplit':
        vim.command('vsplit '+name_file)
    elif how=='tab':
        vim.command('tabnew '+name_file)
    else:
        vim.command('edit '+name_file)
    print(name_file)

# Create a file using the extension delimited and 
# the timestamps or the context used file
def Loadzettel():
    print('Zettelkasten loaded')
    print(zkdir)
    print(zkdelimiter)
    print(zkfiletype)
    pass

# Set the file tags to the current file, if is detected the
# line that assigns tags to a certain file, it will be added new tags
def settags():
    if zkfiletype=='markdown' or zkfiletype=='pandoc':
        zkfiletags='# Tags:'
    elif zkfiletype=='org':
        zkfiletags="#+FILETAGS:"
    else:
        zkfiletags="tags:"
    vim.command('let texto= input("Add tags: ")')
    tags_added=vim.eval('texto')
    vim.command('call search("'+zkfiletags+'")')
    vim.command('let gettheline=getline(".")')
    tagsline=vim.eval('gettheline')
    if zkfiletype=='org':
        if tagsline[-1] != ':':
            vim.command('normal A:'+tags_added+':')
        else:
            vim.command('normal A'+tags_added+':')
    else:
        if tagsline[-1] !=' ':
            vim.command('normal A:'+tags_added+' ')
        else:
            vim.command('normal A'+tags_added)


# Find files passing as argument a keyword 
# and the tags delimiter

def findtags(arg):
    """TODO: Docstring for findtags.

    :arg: tag to be searched
    :returns: TODO

    """
    command_parts= [
            'call fzf#vim#grep(',
            "'rg --column --line-number --no-heading --color=always --smart-case -- ",
            "', 1,",
            'fzf#vim#with_preview())'
            ]
    # zettelvim_dir=vim.eval('g:zettelvim_dir')
    command=command_parts[0]+command_parts[1]+ str(zkdelimiter) + str(arg) \
            + " " + zkdir + command_parts[2] + command_parts[3]
    vim.command(command)


# Insert Link into the current link using file
def inslink():
    # fact=vim.eval('g:zettelvim_dir')
    command_parts=[
            "let zettelname= fzf#run({'source': 'find ",
            ' -type f -maxdepth 1 -printf "%f\\n"', 
            "'})"    
            ]
    command=command_parts[0]+ zkdir + command_parts[1]+command_parts[2]
    vim.command(command)
    zet=vim.eval('zettelname')
    print(type(zet))
    vim.command('normal i'+zet[0])

# Create Index to a file to organize as root files, can be using 
# a tag or a date
def insindex(arg):
    if arg=='date':
        print('date selected')
        vim.command('let datefiles=input("insert the date without symbols")')
        dfile=vim.eval('datefiles')
    elif arg=='tag':
        print('Tags selected')
    else:
        print('error')

    

# Function to insert file into connection files to able the export
def insfile():
    pass

def movefile(arg1):
    """TODO: Docstring for movefile.

    :arg1: TODO
    :returns: TODO

    """
    pass


