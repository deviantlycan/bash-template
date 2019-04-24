#!/usr/bin/env bash

##################################################################
## Name: core-functions.sh
## Description: Reusable functions that can be included in another
## script. 
## Usage example:
## source ${MY_DIR}/std-functions.sh
##################################################################

if [[ -z "$WORKING_DIR" ]]; then
	WORKING_DIR=.
fi

# Global Variables
MY_DIR=$(dirname $(readlink -f $0))
CUR_DIR=$(pwd)
ARGS=()
SCRIPT_NAME=`basename "$0"`
LOG_PREFIX="== "
TMP_DIR=${MY_DIR}/tmp
START_TIME=`date +%s`
QUIET=false
OWNER_NAME=$(whoami)
GROUP_NAME=$(id -g -n)

# This declares an array of key value pairs that contains a command line command as the key and the path to that
# command as the value.
declare -A REQUIRED_CMDS

function init(){
	mkdir -p ${TMP_DIR}
	chgrp ${GROUP_NAME} ${TMP_DIR}
	chmod g+s ${TMP_DIR}
	cd ${WORKING_DIR}
}

# Default cleanup function.
# Clean up the temp working directory
# Override this with a different function in the main script if additional tasks are necessary.
function cleanup(){
	rm -rf ${TMP_DIR}
	cd ${CUR_DIR}
}


# Default Print Help function
# Override this with a different function in the main script if additional tasks are necessary.
function printHelp(){
	log "${SCRIPT_NAME}\n"
	log "Description:\n  -- This script is using the default printHelp function!  This function should be overridden in the main script."
	usage
}

# Default usage information function.
# Override this with a different function in the main script if additional tasks are necessary.
function usage(){
	log "Usage: ${SCRIPT_NAME} [-t | --tmp-dir PATH] [-v | --verbose] [-h | --help] [-q | --quiet]"
	log "Options: "
	log " -t | --tmp-dir	- Sets the temporary working directory, if omitted, ./tmp is used."
	log " -v | --verbose	- Print verbose output"
	log " -h | --help		- Prints the help for this script"
	log " -q | --quiet		- Suppress output"
}

function scriptSpecificUsage(){
	log ""
}

# Prints out the start time and the parameters affecting how this script will run
# Do NOT override this function.  If you want to add additional variable value output,
# create a function named printHeaderVars in the main script that follows the comments in the
# printHeaderVars function in this script
function printHeader(){
	log "=================================================="
	log "Running: ${SCRIPT_NAME}"
	log "Start time: $(date)"
	log "-----------------------------------------------"
	log "Temp Dir: ${TMP_DIR}"
	log "Working Dir: ${WORKING_DIR}"
	log "Quiet Mode: ${QUIET}"
	printHeaderVars
	log "==================================================\n\n"
}

# Override this function in the main script to add additional script specific variables to the printHeader function.
function printHeaderVars(){
	# Example:
	# log "Quiet Mode: ${QUIET}"
	log "Log Prefix: ${LOG_PREFIX}"
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

# Checks if a given command line command is available and adds the path to that command to the REQUIRED_CMDS map

# Example Usage: checkForCmd java
function checkForCmd(){
	CMD_BIN=$(which $1)

	if [[ -x ${CMD_BIN} ]]; then
		REQUIRED_CMDS[$1]=${CMD_BIN}
		log "Using $1 at ${CMD_BIN}"
	else
		log "$1 is not installed!"
	fi
}

# Requires that a command line command be available and exits the script if it is not.
function requireCmd(){
	checkForCmd $1
	log $REQUIRED_CMDS
	if [[ -z ${REQUIRED_CMDS[$1]} ]]; then
		log "ERROR! $1 is not installed!"
		failAndQuit
	fi
}

function addSlashToPathIfMissing(){
	INPUT_PATH=$1

	length=${#INPUT_PATH}
	last_char=${INPUT_PATH:length-1:1}

	if [[ $last_char != "/" ]]; then
		INPUT_PATH="$INPUT_PATH/"
	fi
	echo ${INPUT_PATH}
}

function stripTrailingSlash(){
	INPUT_PATH=$1
	length=${#INPUT_PATH}
	last_char=${INPUT_PATH:length-1:1}

	if [[ $last_char == "/" ]]; then
		INPUT_PATH=${INPUT_PATH:0:length-1}
	fi
	echo ${INPUT_PATH}
}

# Simple log function that handles checking for "quiet" mode
function log (){
	if [[ ${QUIET} == 'false' ]]; then
		printf "$LOG_PREFIX$1\n"
	fi
}

# Abandon ship!!
function failAndQuit(){
	log "Script Failed. :("
	log $1
	exit 1
}

function readArgs(){
	log "Reading command line arguments:"
	for ARG in "${ARGS[@]}"
	do
		log "${ARG}"
	done
}

function processDefaultArgs(){
	if [[ ${ARGS[@]} -eq 0 ]]; then
		readArgs
	fi

	arg_count=${#ARGS[*]}
	for (( i=0; i<=$(( $arg_count -1 )); i++ ))
	do
		case ${ARGS[$i]} in
			-t | --tmp-dir )		TMP_DIR=${ARGS[$i + 1]}
									;;
			-v | --verbose )		set -x # echo on
									;;
			-q | --quiet )			QUIET=true
									;;
			-h | --help )			printHelp
									exit
									;;
		esac
	done
}

# This eats all of the command line arguments and adds them to the global ARGS array
while [[ "$1" != "" ]]
do
	ARGS+=($1)
	shift
done

processDefaultArgs

log "-- std-functions script loaded."
