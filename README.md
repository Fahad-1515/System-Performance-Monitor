# System-Performance-Monitor
Tracks CPU, RAM, and process usage  Automatically kills the highest RAM-consuming process (if thresholds are exceeded)  Runs in the background (as a systemd service or cron job)

 Key Features Demonstrated 
 
✅ Real-time RAM monitoring

✅ Automatic process termination (prevents OOM crashes)

✅ Logging for audit/debugging

✅ Runs as a background service

To Make It Executable

chmod +x system_monitor.sh

--------------------------->Run in Background<------------------------------------------ 

To Run via cron

Add to root’s crontab (sudo crontab -e):

bash
*****/home/user/scripts/system_monitor.sh >/dev/null 2>&1                     

Test the Script
Simulate high RAM usage:

bash:
stress-ng --vm 1 --vm-bytes 90% --vm-method all -t 1m
Check logs:

bash:
tail -f /var/log/system_monitor.log
Example output:

text
[2024-03-15 12:00:00] OK: RAM usage at 45% (Threshold: 90%)
[2024-03-15 12:00:30] WARNING: RAM usage at 95% - Identifying top process...
[2024-03-15 12:00:30] Killing process: stress-ng (PID: 1234, RAM: 85%)
