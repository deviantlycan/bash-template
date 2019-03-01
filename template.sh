#!/usr/bin/env bash

##################################################################
## Name: template.sh
## Description: Bad ass bash file template
## Author: Scott McArthur (scott@antbytes.com)
## Abstract:
## I love making bash scripts and find that the more standard 
## mechanisms that they have, the more useful they are for 
## everyone, whether that be the creator or anyone else that needs
## to use it.  I made this for my own use, but hopefully it will 
## help someone else and make their lives easier and their scripts
## better.
##################################################################

if [[ -z "$WORKING_DIR" ]]; then
	WORKING_DIR=.
fi

# global variables
TMP_DIR=${WORKING_DIR}/tmp
START_TIME=
QUIET=false
SCRIPT_NAME=`basename "$0"`
LOG_PREFIX="=="

# Main entry point after parameters are read.
function main(){
	init
	printHeader
	doAlltheThings
	cleanup
	printFooter
}

# This is where main functionality goes.  Feel free to rename this function or to do whatever you want.
function doAlltheThings(){
	printf "===========================================================================\n"
	printf "== ${SCRIPT_NAME} \n"
	printf "== This is a bash script template and has not been configured to do anything.\n"
	printf "===========================================================================\n"

	printf "WAKA - WAKA- WAKA- WAKA- WAKA- WAKA- WAKA\n"
	printf "▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄\n"
	printf "▒▓▒░▒▓▒░▒▓▒░▒▓▒░▒▓▒░▒▓▒░▒▓▒░▒▓▒░▒▓▒░▒▓▒░\n"
	printf "▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀\n"
	printf "▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄\n"
	printf "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓\n"
	printf "▓▓▀────▀▓▓▓▓▓▓▀─────▀▓▓▓▓▓▓▓▓▓▓▓▀─────▀▓\n"
	printf "▓───▀─▄▓▓▓▓▓▓▓─▀──▀──▓▓▓▓▓▓▓▓▓▓▓──▀──▀─▓\n"
	printf "▌────▓▓▓─▓▓─▓▓──▄─▄──▓▓─▓▓─▓▓─▓▓──▄─▄──▓\n"
	printf "▓─────▀▓▓▓▓▓▓▓─▀─▀─▀─▓▓▓▓▓▓▓▓▓▓▓─▀─▀─▀─▓\n"
	printf "▓▓▄────▄▓▓▓▓▓▓─▄─▄─▄─▓▓▓▓▓▓▓▓▓▓▓─▄─▄─▄─▓\n"
	printf "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓\n"
	printf "▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀\n"
	printf "▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄\n"
	printf "▒▓▒░▒▓▒░▒▓▒░▒▓▒░▒▓▒░▒▓▒░▒▓▒░▒▓▒░▒▓▒░▒▓▒░\n"
	printf "▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀\n"
	printf "WAKA - WAKA- WAKA- WAKA- WAKA- WAKA- WAKA\n"
}

# This initializes the start time and creates the temp working directory
function init(){
	START_TIME=`date +%s`
	mkdir ${TMP_DIR}
}

# Clean up the temp working directory 
# Add anything here that needs to be done after all main tasks are complete.
function cleanup(){
	rm -rf ${TMP_DIR}
}

# Prints out the start time and the parameters affecting how this script will run
function printHeader(){
	log "=================================================="
	log "== Running: ${SCRIPT_NAME}"
	log "== Start time: $(date)"
	log "== -----------------------------------------------"
	log "== Temp Dir: ${TMP_DIR}"
	log "==================================================\n\n"
}

# Prints a summary of the script execution.
function printFooter(){
	END_TIME=`date +%s`
	TOTAL_RUN_TIME=$((END_TIME-START_TIME))
	log "\n=================================================="
	log "== End Time: $(date)"
	log "== Total Run Time: ${TOTAL_RUN_TIME} seconds."
	log "== ${SCRIPT_NAME} Complete"
	log "=================================================="
}

# Print Help
function printHelp()
{
	printf "== ${SCRIPT_NAME} ==\n"
	printf "Description:\n  -- This script does AlltheThings ;)  \n Clearly the Description has not been set yet.  :/ \n Here is a cool Pac-Man for now... \n\n"
	printf "──▒▒▒▒▒────▄████▄─────\n"
	printf "─▒─▄▒─▄▒──███▄█▀──────\n"
	printf "─▒▒▒▒▒▒▒─▐████──█──█──\n"
	printf "─▒▒▒▒▒▒▒──█████▄──────\n"
	printf "─▒─▒─▒─▒───▀████▀─────\n"
	usage
}

# Prints usage information
function usage()
{
	printf "Usage: ${SCRIPT_NAME} [-t | --tmp-dir PATH] [-v | --verbose] [-h | --help] [-q | --quiet]\n"
	printf "Options: \n"
	printf " -t | --tmp-dir		- Sets the temporary working directory, if omitted, ./tmp is used.\n"
	printf " -v | --verbose		- Print verbose output\n"
	printf " -h | --help		- Prints the help for this script\n"
	printf " -q | --quiet		- Suppress output\n"
}

# Simple log function that handles checking for "quiet" mode
function log (){
	if [[ ${QUIET} == 'false' ]]; then
		printf "$LOG_PREFIX$1\n"
	fi
}

# Reads the command line parameters
while [[ "$1" != "" ]]
do
	case $1 in
		-t | --tmp-dir )		shift
								TMP_DIR=$1
								;;
		-v | --verbose )		set -x # echo on
								;;
		-q | --quiet )			QUIET=true
								;;
		-h | --help )			printHelp
								exit
								;;
		* )						printHelp
								exit 1
	esac
	shift
done

main
