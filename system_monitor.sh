#!/bin/bash
# System Performance Monitor & OOM Killer

# Thresholds (adjust as needed)
MAX_RAM_PERCENT=90  # Kill if RAM usage >90%
LOG_FILE="/var/log/system_monitor.log"

log() {
  echo "[$(date)] $1" >> "$LOG_FILE"
}

check_ram() {
  RAM_PERCENT=$(free | awk '/Mem:/ {print $3/$2 * 100.0}')
  RAM_PERCENT=${RAM_PERCENT%.*}  # Convert to integer

  if [ "$RAM_PERCENT" -ge "$MAX_RAM_PERCENT" ]; then
    log "WARNING: RAM usage at ${RAM_PERCENT}% - Identifying top process..."
    
    # Get the highest RAM-using process
    KILL_PID=$(ps -eo pid,%mem --sort=-%mem | awk 'NR==2 {print $1}')
    KILL_NAME=$(ps -p "$KILL_PID" -o comm=)
    KILL_MEM=$(ps -p "$KILL_PID" -o %mem=)

    log "Killing process: $KILL_NAME (PID: $KILL_PID, RAM: ${KILL_MEM}%)"
    kill -9 "$KILL_PID" && log "Process killed."
  else
    log "OK: RAM usage at ${RAM_PERCENT}% (Threshold: ${MAX_RAM_PERCENT}%)"
  fi
}

# Main loop
while true; do
  check_ram
  sleep 30  # Check every 30 seconds
done
