/***********************************************************************
**
**  REBOL [R3] Language Interpreter and Run-time Environment
**  Copyright 2012 REBOL Technologies
**  REBOL is a trademark of REBOL Technologies
**  Licensed under the Apache License, Version 2.0
**  This is a code-generated file.
**
************************************************************************
**
**  Title: System Object
**  Build: A0
**  Date:  10-Feb-2021
**  File:  sysobj.h
**
**  AUTO-GENERATED FILE - Do not modify. (From: make-boot.reb)
**
***********************************************************************/


enum SYS_object {
	SYS_SELF = 0,
	SYS_PRODUCT,
	SYS_PLATFORM,
	SYS_VERSION,
	SYS_BUILD,
	SYS_LICENSE,
	SYS_CATALOG,
	SYS_CONTEXTS,
	SYS_STATE,
	SYS_MODULES,
	SYS_CODECS,
	SYS_DIALECTS,
	SYS_SCHEMES,
	SYS_PORTS,
	SYS_LOCALE,
	SYS_OPTIONS,
	SYS_SCRIPT,
	SYS_STANDARD,
	SYS_VIEW,
	SYS_MAX
};

enum CAT_object {
	CAT_SELF = 0,
	CAT_DATATYPES,
	CAT_ACTIONS,
	CAT_NATIVES,
	CAT_HANDLES,
	CAT_ERRORS,
	CAT_REFLECTORS,
	CAT_BOOT_FLAGS,
	CAT_BITSETS,
	CAT_CHECKSUMS,
	CAT_MAX
};

enum CAT_BITSETS_object {
	CAT_BITSETS_SELF = 0,
	CAT_BITSETS_CRLF,
	CAT_BITSETS_WHITESPACE,
	CAT_BITSETS_NUMERIC,
	CAT_BITSETS_ALPHA,
	CAT_BITSETS_ALPHA_NUMERIC,
	CAT_BITSETS_HEX_DIGITS,
	CAT_BITSETS_URI,
	CAT_BITSETS_URI_COMPONENT,
	CAT_BITSETS_MAX
};

enum CTX_object {
	CTX_SELF = 0,
	CTX_ROOT,
	CTX_SYS,
	CTX_LIB,
	CTX_USER,
	CTX_MAX
};

enum STD_object {
	STD_SELF = 0,
	STD_CODEC,
	STD_ENUM,
	STD_ERROR,
	STD_SCRIPT,
	STD_HEADER,
	STD_SCHEME,
	STD_PORT,
	STD_PORT_SPEC_HEAD,
	STD_PORT_SPEC_FILE,
	STD_PORT_SPEC_NET,
	STD_PORT_SPEC_CHECKSUM,
	STD_PORT_SPEC_MIDI,
	STD_FILE_INFO,
	STD_NET_INFO,
	STD_CONSOLE_INFO,
	STD_VECTOR_INFO,
	STD_DATE_INFO,
	STD_MIDI_INFO,
	STD_EXTENSION,
	STD_STATS,
	STD_TYPE_SPEC,
	STD_BINCODE,
	STD_UTYPE,
	STD_FONT,
	STD_PARA,
	STD_MAX
};

enum STD_CODEC_object {
	STD_CODEC_SELF = 0,
	STD_CODEC_NAME,
	STD_CODEC_TITLE,
	STD_CODEC_SUFFIXES,
	STD_CODEC_DECODE,
	STD_CODEC_ENCODE,
	STD_CODEC_IDENTIFY,
	STD_CODEC_MAX
};

enum STD_ERROR_object {
	STD_ERROR_SELF = 0,
	STD_ERROR_CODE,
	STD_ERROR_TYPE,
	STD_ERROR_ID,
	STD_ERROR_ARG1,
	STD_ERROR_ARG2,
	STD_ERROR_ARG3,
	STD_ERROR_NEAR,
	STD_ERROR_WHERE,
	STD_ERROR_MAX
};

enum STD_SCRIPT_object {
	STD_SCRIPT_SELF = 0,
	STD_SCRIPT_TITLE,
	STD_SCRIPT_HEADER,
	STD_SCRIPT_PARENT,
	STD_SCRIPT_PATH,
	STD_SCRIPT_ARGS,
	STD_SCRIPT_MAX
};

enum STD_HEADER_object {
	STD_HEADER_SELF = 0,
	STD_HEADER_TITLE,
	STD_HEADER_NAME,
	STD_HEADER_TYPE,
	STD_HEADER_VERSION,
	STD_HEADER_DATE,
	STD_HEADER_FILE,
	STD_HEADER_AUTHOR,
	STD_HEADER_NEEDS,
	STD_HEADER_OPTIONS,
	STD_HEADER_CHECKSUM,
	STD_HEADER_MAX
};

enum STD_SCHEME_object {
	STD_SCHEME_SELF = 0,
	STD_SCHEME_NAME,
	STD_SCHEME_TITLE,
	STD_SCHEME_SPEC,
	STD_SCHEME_INFO,
	STD_SCHEME_ACTOR,
	STD_SCHEME_AWAKE,
	STD_SCHEME_MAX
};

enum STD_PORT_object {
	STD_PORT_SELF = 0,
	STD_PORT_SPEC,
	STD_PORT_SCHEME,
	STD_PORT_ACTOR,
	STD_PORT_AWAKE,
	STD_PORT_STATE,
	STD_PORT_DATA,
	STD_PORT_LOCALS,
	STD_PORT_MAX
};

enum STD_PORT_SPEC_HEAD_object {
	STD_PORT_SPEC_HEAD_SELF = 0,
	STD_PORT_SPEC_HEAD_TITLE,
	STD_PORT_SPEC_HEAD_SCHEME,
	STD_PORT_SPEC_HEAD_REF,
	STD_PORT_SPEC_HEAD_MAX
};

enum STD_PORT_SPEC_FILE_object {
	STD_PORT_SPEC_FILE_SELF = 0,
	STD_PORT_SPEC_FILE_TITLE,
	STD_PORT_SPEC_FILE_SCHEME,
	STD_PORT_SPEC_FILE_REF,
	STD_PORT_SPEC_FILE_PATH,
	STD_PORT_SPEC_FILE_MAX
};

enum STD_PORT_SPEC_NET_object {
	STD_PORT_SPEC_NET_SELF = 0,
	STD_PORT_SPEC_NET_TITLE,
	STD_PORT_SPEC_NET_SCHEME,
	STD_PORT_SPEC_NET_REF,
	STD_PORT_SPEC_NET_PATH,
	STD_PORT_SPEC_NET_HOST,
	STD_PORT_SPEC_NET_PORT_ID,
	STD_PORT_SPEC_NET_MAX
};

enum STD_PORT_SPEC_CHECKSUM_object {
	STD_PORT_SPEC_CHECKSUM_SELF = 0,
	STD_PORT_SPEC_CHECKSUM_TITLE,
	STD_PORT_SPEC_CHECKSUM_SCHEME,
	STD_PORT_SPEC_CHECKSUM_REF,
	STD_PORT_SPEC_CHECKSUM_METHOD,
	STD_PORT_SPEC_CHECKSUM_MAX
};

enum STD_PORT_SPEC_MIDI_object {
	STD_PORT_SPEC_MIDI_SELF = 0,
	STD_PORT_SPEC_MIDI_TITLE,
	STD_PORT_SPEC_MIDI_SCHEME,
	STD_PORT_SPEC_MIDI_REF,
	STD_PORT_SPEC_MIDI_DEVICE_IN,
	STD_PORT_SPEC_MIDI_DEVICE_OUT,
	STD_PORT_SPEC_MIDI_MAX
};

enum STD_FILE_INFO_object {
	STD_FILE_INFO_SELF = 0,
	STD_FILE_INFO_NAME,
	STD_FILE_INFO_SIZE,
	STD_FILE_INFO_DATE,
	STD_FILE_INFO_TYPE,
	STD_FILE_INFO_MAX
};

enum STD_NET_INFO_object {
	STD_NET_INFO_SELF = 0,
	STD_NET_INFO_LOCAL_IP,
	STD_NET_INFO_LOCAL_PORT,
	STD_NET_INFO_REMOTE_IP,
	STD_NET_INFO_REMOTE_PORT,
	STD_NET_INFO_MAX
};

enum STD_CONSOLE_INFO_object {
	STD_CONSOLE_INFO_SELF = 0,
	STD_CONSOLE_INFO_BUFFER_COLS,
	STD_CONSOLE_INFO_BUFFER_ROWS,
	STD_CONSOLE_INFO_WINDOW_COLS,
	STD_CONSOLE_INFO_WINDOW_ROWS,
	STD_CONSOLE_INFO_MAX
};

enum STD_VECTOR_INFO_object {
	STD_VECTOR_INFO_SELF = 0,
	STD_VECTOR_INFO_SIGNED,
	STD_VECTOR_INFO_TYPE,
	STD_VECTOR_INFO_SIZE,
	STD_VECTOR_INFO_LENGTH,
	STD_VECTOR_INFO_MAX
};

enum STD_DATE_INFO_object {
	STD_DATE_INFO_SELF = 0,
	STD_DATE_INFO_YEAR,
	STD_DATE_INFO_MONTH,
	STD_DATE_INFO_DAY,
	STD_DATE_INFO_TIME,
	STD_DATE_INFO_DATE,
	STD_DATE_INFO_ZONE,
	STD_DATE_INFO_HOUR,
	STD_DATE_INFO_MINUTE,
	STD_DATE_INFO_SECOND,
	STD_DATE_INFO_WEEKDAY,
	STD_DATE_INFO_YEARDAY,
	STD_DATE_INFO_TIMEZONE,
	STD_DATE_INFO_UTC,
	STD_DATE_INFO_JULIAN,
	STD_DATE_INFO_MAX
};

enum STD_MIDI_INFO_object {
	STD_MIDI_INFO_SELF = 0,
	STD_MIDI_INFO_DEVICES_IN,
	STD_MIDI_INFO_DEVICES_OUT,
	STD_MIDI_INFO_MAX
};

enum STD_EXTENSION_object {
	STD_EXTENSION_SELF = 0,
	STD_EXTENSION_LIB_BASE,
	STD_EXTENSION_LIB_FILE,
	STD_EXTENSION_LIB_BOOT,
	STD_EXTENSION_COMMAND,
	STD_EXTENSION_CMD_INDEX,
	STD_EXTENSION_WORDS,
	STD_EXTENSION_MAX
};

enum STD_STATS_object {
	STD_STATS_SELF = 0,
	STD_STATS_TIMER,
	STD_STATS_EVALS,
	STD_STATS_EVAL_NATIVES,
	STD_STATS_EVAL_FUNCTIONS,
	STD_STATS_SERIES_MADE,
	STD_STATS_SERIES_FREED,
	STD_STATS_SERIES_EXPANDED,
	STD_STATS_SERIES_BYTES,
	STD_STATS_SERIES_RECYCLED,
	STD_STATS_MADE_BLOCKS,
	STD_STATS_MADE_OBJECTS,
	STD_STATS_RECYCLES,
	STD_STATS_MAX
};

enum STD_TYPE_SPEC_object {
	STD_TYPE_SPEC_SELF = 0,
	STD_TYPE_SPEC_TITLE,
	STD_TYPE_SPEC_TYPE,
	STD_TYPE_SPEC_MAX
};

enum STATE_object {
	STATE_SELF = 0,
	STATE_NOTE,
	STATE_POLICIES,
	STATE_LAST_ERROR,
	STATE_MAX
};

enum STATE_POLICIES_object {
	STATE_POLICIES_SELF = 0,
	STATE_POLICIES_FILE,
	STATE_POLICIES_NET,
	STATE_POLICIES_EVAL,
	STATE_POLICIES_MEMORY,
	STATE_POLICIES_SECURE,
	STATE_POLICIES_PROTECT,
	STATE_POLICIES_DEBUG,
	STATE_POLICIES_ENVR,
	STATE_POLICIES_CALL,
	STATE_POLICIES_BROWSE,
	STATE_POLICIES_EXTENSION,
	STATE_POLICIES_MAX
};

enum PORTS_object {
	PORTS_SELF = 0,
	PORTS_WAIT_LIST,
	PORTS_INPUT,
	PORTS_OUTPUT,
	PORTS_ECHO,
	PORTS_SYSTEM,
	PORTS_CALLBACK,
	PORTS_MAX
};

enum OPTIONS_object {
	OPTIONS_SELF = 0,
	OPTIONS_BOOT,
	OPTIONS_PATH,
	OPTIONS_HOME,
	OPTIONS_FLAGS,
	OPTIONS_SCRIPT,
	OPTIONS_ARGS,
	OPTIONS_DO_ARG,
	OPTIONS_IMPORT,
	OPTIONS_DEBUG,
	OPTIONS_SECURE,
	OPTIONS_VERSION,
	OPTIONS_BOOT_LEVEL,
	OPTIONS_QUIET,
	OPTIONS_BINARY_BASE,
	OPTIONS_DECIMAL_DIGITS,
	OPTIONS_MODULE_PATHS,
	OPTIONS_DEFAULT_SUFFIX,
	OPTIONS_FILE_TYPES,
	OPTIONS_RESULT_TYPES,
	OPTIONS_LOG,
	OPTIONS_MAX
};

enum LOCALE_object {
	LOCALE_SELF = 0,
	LOCALE_LANGUAGE,
	LOCALE_LANGUAGE_P,
	LOCALE_LOCALE,
	LOCALE_LOCALE_P,
	LOCALE_MONTHS,
	LOCALE_DAYS,
	LOCALE_MAX
};

enum VIEW_object {
	VIEW_SELF = 0,
	VIEW_SCREEN_GOB,
	VIEW_HANDLER,
	VIEW_EVENT_PORT,
	VIEW_METRICS,
	VIEW_EVENT_TYPES,
	VIEW_EVENT_KEYS,
	VIEW_MAX
};

enum VIEW_METRICS_object {
	VIEW_METRICS_SELF = 0,
	VIEW_METRICS_SCREEN_SIZE,
	VIEW_METRICS_BORDER_SIZE,
	VIEW_METRICS_BORDER_FIXED,
	VIEW_METRICS_TITLE_SIZE,
	VIEW_METRICS_WORK_ORIGIN,
	VIEW_METRICS_WORK_SIZE,
	VIEW_METRICS_MAX
};

