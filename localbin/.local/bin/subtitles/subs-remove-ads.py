#!/usr/bin/env python3
###
# requires python310 or higher to run native, use the compiled linux (like an sh file) or windows exe otherwise
# USAGE Single file OR Bazarr post process:
#   WINDOWS:   python3 "\_scratch\scripts\remove_ads_from_subtitles.py" "C:\Users\user\Downloads\temp\subtitle.srt" "iunno|begiggle"
#			  python3 "\_scratch\scripts\remove_ads_from_subtitles.py" "{{subtitles}}"
#
#   Linux:	 python3 /_scratch/scripts/remove_ads_from_subtitles.py '{{subtitles}}' "iunno|begiggle"
#
# second arg is OPTIONAL to add more regex checks without changing code. They will get appended to regex_to_find
# add with "" separated by pipes | and ensure no spaces in between pipes | unless spaces are to be matched
# if second arg is literally "doall" - then third arg should be full path to root folder of all subs to process - first arg must be set but can be anything
# (for wanting to do a batch of all current srt files) i.e
# python3 "\_scratch\scripts\remove_ads_from_subtitles.py" "nothing" "doall" "\video\"
###

### imports
import re, os, sys, fileinput, codecs
from pathlib import Path

### startup
regex_to_find = 'Downloaded from|Support us and become a VIP member|Support us and become VIP member|subtitles|corrected by|corrections by|rate this subtitle|created by|Advertise your product or brand here|tvsubtitles|YTS|YIFY|www\.|https:|ripped by|opensubtitles|sub(scene|rip)|podnapisi|addic7ed|titlovi|bozxphd|sazu489|psagmeno|normita|anoxmous|\. ?com|©|™|Free Online Movies|Subtitle edited by|thepiratebay|Polish Subtitles by|Napisy :|Napisy zostały specjalnie dopasowane|Napisy24|Proszę, oceń te napisy|Pomóż innym wybrać najlepsze napisy|Wspomóż nas i zostań członkiem VIP|by Kreonium|Korekta by|SubtitleDB|choose the best subtitles|Napisy dla|Pele144|MuRu|napiprojekt|Best watched using|Open Subtitles|napisy.org|sluggard|napisy przeznaczone wyłącznie|do celów niekomercyjnych'
do_all = False

if len(sys.argv) > 2:
	if sys.argv[2] == 'doall':
		if sys.argv[3]:
			do_all = True
			print("Do All Selected")
		else:
			do_all = False
	else:
		do_all = False
		regex_to_find = regex_to_find + '|' + sys.argv[2]

### functions
def checkCodec(path_to_file):
	try:
		f = codecs.open(path_to_file, encoding='utf-8', errors='strict')
		for line in f:
			pass
		return(True)
	except UnicodeDecodeError:
		return(False)

def print_to_stdout(*a):
	try:
		print(*a, file = sys.stdout)
	except:
		return

def stripAds(path_to_file):
	standard_modified = "[[ Standard Subtitle --> Nothing to be Modified ]]"
	sync_modified = "[[ SYNCED Subtitle --> Not found ]"
	do_synced = True
	if os.path.isfile(path_to_file):
		file_path_parts_list = Path(str(path_to_file)).parts # break the path up into an array
		file_name = file_path_parts_list[-1]
		file_path = str(Path(path_to_file).parent)
		if 'synced' in file_name:
			do_synced = False
		# start mod
		for line in fileinput.input(path_to_file, inplace = True, encoding="utf-8"):
			try:
				if not re.search(regex_to_find, line, re.IGNORECASE):
					print(line, end="")
				else:
					standard_modified = "[[ Standard Subtitle --> Modified! ]]"
			except Exception as ex:
				sync_modified = "[[ SYNCED Subtitle --> " + str(ex) + " ]"
				continue
		if do_synced:
			# do the same for synced version
			sync_file_name = file_name.split('.srt')[0] + '.synced.srt'
			if 'win' in sys.platform:
				sync_file_full = file_path + '\\' + sync_file_name
			else:
				sync_file_full = file_path + '/' + sync_file_name
			if os.path.isfile(sync_file_full):
				for line in fileinput.input(sync_file_full, inplace = True, encoding="utf-8"):
					try:
						if not re.search(regex_to_find, line, re.IGNORECASE):
							print(line, end="")
							sync_modified = "[[ SYNCED Subtitle --> Nothing to be Modified ]]"
						else:
							sync_modified = "[[ SYNCED Subtitle --> Modified! ]]"
					except Exception as ex:
						sync_modified = "[[ SYNCED Subtitle --> " + str(ex) + " ]"
						continue
			else:
				sync_modified = "[[ SYNCED Subtitle --> Not found ]"
		return_str = 'Remove-Ads-From-Subs: ' + standard_modified + ' - ' + sync_modified
		return(return_str)
	else:
		return('Remove-Ads-From-Subs: No standard subtitle found?!')

### RUNTIME
# first argument should be path to srt file
if len(sys.argv) == 1:
	sys.exit()
else:
	if not do_all:
		print_to_stdout(stripAds(sys.argv[1]))
	else:
		all_subtitles_list = []
		root_folder = sys.argv[3]
		for root, dirs, files in os.walk(root_folder):
			for file in files:
				if file.endswith('.srt'):
					if 'synced' in file:
						continue
					file_full = os.path.join(root, file)
					if not checkCodec(file_full):
						continue
					print(file_full)
					all_subtitles_list.append(file_full)
		for subtitle in all_subtitles_list:
#			print( stripAds(subtitle) )
			print(str(subtitle) + ": " + str(stripAds(subtitle)))

	sys.exit()
