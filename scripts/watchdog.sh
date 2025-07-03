#!/bin/bash
#
# Watchdog Script - Dotfiles Security Monitoring
# Monitors filesystem for unauthorized configuration changes
# Part of GitOps hardening and security audit process
#
# Usage: ./scripts/watchdog.sh [options]
# Options:
#   -d, --daemon    Run as daemon in background
#   -v, --verbose   Enable verbose logging
#   -h, --help      Show help message
#

set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
LOG_FILE="${PROJECT_ROOT}/watchdog.log"
PID_FILE="${PROJECT_ROOT}/watchdog.pid"

# Color codes for output
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Global variables
DAEMON_MODE=false
VERBOSE=false
MONITORING=true

# Approved directories for configuration changes
APPROVED_DIRS=(
    ".config"
    "scripts"
    ".git"
)

# File patterns to ignore
IGNORE_PATTERNS=(
    "*.log"
    "*.pid"
    "*.tmp"
    "*.swp"
    "*.bak"
    ".git/*"
    "watchdog.log"
    "watchdog.pid"
)

# Function to log messages
log_message() {
    local level="$1"
    local message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    case "$level" in
        "ERROR")
            echo -e "${RED}[ERROR]${NC} $message" >&2
            echo "[$timestamp] [ERROR] $message" >> "$LOG_FILE"
            ;;
        "WARNING")
            echo -e "${YELLOW}[WARNING]${NC} $message" >&2
            echo "[$timestamp] [WARNING] $message" >> "$LOG_FILE"
            ;;
        "INFO")
            echo -e "${GREEN}[INFO]${NC} $message"
            echo "[$timestamp] [INFO] $message" >> "$LOG_FILE"
            ;;
        "DEBUG")
            if [ "$VERBOSE" = true ]; then
                echo -e "${BLUE}[DEBUG]${NC} $message"
                echo "[$timestamp] [DEBUG] $message" >> "$LOG_FILE"
            fi
            ;;
    esac
}

# Function to check if file should be ignored
should_ignore_file() {
    local file="$1"
    local basename_file=$(basename "$file")
    
    for pattern in "${IGNORE_PATTERNS[@]}"; do
        case "$basename_file" in
            $pattern)
                return 0
                ;;
        esac
        
        case "$file" in
            $pattern)
                return 0
                ;;
        esac
    done
    
    return 1
}

# Function to check if directory is approved
is_approved_directory() {
    local file_path="$1"
    
    for approved_dir in "${APPROVED_DIRS[@]}"; do
        if [[ "$file_path" == "$approved_dir"* ]] || [[ "$file_path" == "./$approved_dir"* ]]; then
            return 0
        fi
    done
    
    return 1
}

# Function to handle file system events
handle_file_event() {
    local event_type="$1"
    local file_path="$2"
    
    # Skip if file should be ignored
    if should_ignore_file "$file_path"; then
        log_message "DEBUG" "Ignoring file: $file_path"
        return 0
    fi
    
    # Check if the file is in an approved directory
    if is_approved_directory "$file_path"; then
        log_message "DEBUG" "Approved change in $file_path ($event_type)"
        return 0
    fi
    
    # Alert for unauthorized changes
    case "$event_type" in
        "CREATE"|"MODIFY")
            log_message "WARNING" "Unauthorized file change detected: $file_path ($event_type)"
            send_alert "$event_type" "$file_path"
            ;;
        "DELETE")
            log_message "INFO" "File deleted: $file_path"
            ;;
        *)
            log_message "DEBUG" "File event: $file_path ($event_type)"
            ;;
    esac
}

# Function to send security alert
send_alert() {
    local event_type="$1"
    local file_path="$2"
    
    log_message "ERROR" "SECURITY ALERT: Unauthorized $event_type detected in $file_path"
    
    # Display desktop notification if available
    if command -v notify-send &> /dev/null; then
        notify-send "Dotfiles Security Alert" "Unauthorized $event_type: $file_path" -u critical
    fi
    
    # Add to security log
    echo "$(date '+%Y-%m-%d %H:%M:%S') - SECURITY ALERT: $event_type in $file_path" >> "${PROJECT_ROOT}/security-alerts.log"
}

# Function to monitor using inotify (Linux)
monitor_with_inotify() {
    if ! command -v inotifywait &> /dev/null; then
        log_message "ERROR" "inotifywait not available. Install inotify-tools package."
        return 1
    fi
    
    log_message "INFO" "Starting filesystem monitoring with inotify..."
    
    inotifywait -m -r -e create,modify,delete,move --format '%e %w%f' "$PROJECT_ROOT" 2>/dev/null | \
    while read -r event file; do
        if [ "$MONITORING" = true ]; then
            handle_file_event "$event" "$file"
        fi
    done
}

# Function to monitor using fswatch (macOS/cross-platform)
monitor_with_fswatch() {
    if ! command -v fswatch &> /dev/null; then
        log_message "ERROR" "fswatch not available. Install fswatch package."
        return 1
    fi
    
    log_message "INFO" "Starting filesystem monitoring with fswatch..."
    
    fswatch -r "$PROJECT_ROOT" | \
    while read -r file; do
        if [ "$MONITORING" = true ]; then
            handle_file_event "MODIFY" "$file"
        fi
    done
}

# Function to monitor using polling (fallback)
monitor_with_polling() {
    log_message "INFO" "Starting filesystem monitoring with polling (fallback method)..."
    
    local last_check=$(date +%s)
    
    while [ "$MONITORING" = true ]; do
        local current_time=$(date +%s)
        
        # Check for new files every 10 seconds
        if [ $((current_time - last_check)) -ge 10 ]; then
            find "$PROJECT_ROOT" -type f -newermt "@$last_check" ! -path "*/.git/*" 2>/dev/null | \
            while read -r file; do
                if [ "$MONITORING" = true ]; then
                    handle_file_event "MODIFY" "$file"
                fi
            done
            last_check=$current_time
        fi
        
        sleep 2
    done
}

# Function to start monitoring
start_monitoring() {
    log_message "INFO" "Starting dotfiles watchdog monitoring..."
    
    # Create log file if it doesn't exist
    touch "$LOG_FILE"
    
    # Try different monitoring methods in order of preference
    if monitor_with_inotify; then
        return 0
    elif monitor_with_fswatch; then
        return 0
    else
        monitor_with_polling
        return 0
    fi
}

# Function to stop monitoring
stop_monitoring() {
    log_message "INFO" "Stopping dotfiles watchdog monitoring..."
    MONITORING=false
    
    if [ -f "$PID_FILE" ]; then
        local pid=$(cat "$PID_FILE")
        if kill -0 "$pid" 2>/dev/null; then
            kill "$pid"
            log_message "INFO" "Watchdog process (PID: $pid) stopped"
        fi
        rm -f "$PID_FILE"
    fi
}

# Function to show status
show_status() {
    if [ -f "$PID_FILE" ]; then
        local pid=$(cat "$PID_FILE")
        if kill -0 "$pid" 2>/dev/null; then
            log_message "INFO" "Watchdog is running (PID: $pid)"
            return 0
        else
            log_message "WARNING" "Watchdog PID file exists but process is not running"
            rm -f "$PID_FILE"
            return 1
        fi
    else
        log_message "INFO" "Watchdog is not running"
        return 1
    fi
}

# Signal handlers
cleanup() {
    log_message "INFO" "Received signal, cleaning up..."
    stop_monitoring
    exit 0
}

# Set up signal handlers
trap cleanup SIGINT SIGTERM

# Function to show help
show_help() {
    cat << EOF
Dotfiles Watchdog - Filesystem Security Monitor

Usage: $0 [OPTIONS]

OPTIONS:
    -d, --daemon     Run as daemon in background
    -v, --verbose    Enable verbose logging
    -s, --stop       Stop running watchdog
    -t, --status     Show watchdog status
    -h, --help       Show this help message

DESCRIPTION:
    Monitors the dotfiles directory for unauthorized configuration changes.
    Alerts when files are created or modified outside of approved directories.
    
    Approved directories: ${APPROVED_DIRS[*]}
    
    Log file: $LOG_FILE
    PID file: $PID_FILE

EXAMPLES:
    $0                    # Run in foreground
    $0 -d                 # Run as daemon
    $0 -v                 # Run with verbose logging
    $0 --stop             # Stop running watchdog
    $0 --status           # Check status

EOF
}

# Main function
main() {
    local start_daemon=false
    local show_status_flag=false
    local stop_watchdog=false
    
    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -d|--daemon)
                start_daemon=true
                shift
                ;;
            -v|--verbose)
                VERBOSE=true
                shift
                ;;
            -s|--stop)
                stop_watchdog=true
                shift
                ;;
            -t|--status)
                show_status_flag=true
                shift
                ;;
            -h|--help)
                show_help
                exit 0
                ;;
            *)
                log_message "ERROR" "Unknown option: $1"
                show_help
                exit 1
                ;;
        esac
    done
    
    # Handle different actions
    if [ "$stop_watchdog" = true ]; then
        stop_monitoring
        exit 0
    elif [ "$show_status_flag" = true ]; then
        show_status
        exit $?
    fi
    
    # Check if already running
    if [ -f "$PID_FILE" ]; then
        local pid=$(cat "$PID_FILE")
        if kill -0 "$pid" 2>/dev/null; then
            log_message "ERROR" "Watchdog is already running (PID: $pid)"
            exit 1
        else
            rm -f "$PID_FILE"
        fi
    fi
    
    # Start monitoring
    if [ "$start_daemon" = true ]; then
        log_message "INFO" "Starting watchdog in daemon mode..."
        nohup "$0" > /dev/null 2>&1 &
        echo $! > "$PID_FILE"
        log_message "INFO" "Watchdog started as daemon (PID: $!)"
    else
        echo $$ > "$PID_FILE"
        start_monitoring
    fi
}

# Check if script is being sourced or executed
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi 