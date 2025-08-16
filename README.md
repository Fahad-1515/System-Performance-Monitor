# System-Performance-Monitor
Tracks CPU, RAM, and process usage  Automatically kills the highest RAM-consuming process (if thresholds are exceeded)  Runs in the background ( cron job or as a systemd service)

 Key Features Demonstrated 
 
✅ Real-time RAM monitoring

✅ Automatic process termination (prevents OOM crashes)

✅ Logging for audit/debugging

✅ Runs as a background service

To Make It Executable

$chmod +x system_monitor.sh

--------------------------->Run in Background<------------------------------------------ 

To Run via cron

Add to root’s crontab (sudo crontab -e):

$*****/home/user/scripts/system_monitor.sh >/dev/null 2>&1                     

Test the Script
Simulate high RAM usage:


$stress-ng --vm 1 --vm-bytes 90% --vm-method all -t 1m

Check logs:

$tail -f /var/log/system_monitor.log

Example output :

[2025-06-18 12:00:00] OK: RAM usage at 45% (Threshold: 90%)

[2025-06-18 12:00:30] WARNING: RAM usage at 95% - Identifying top process...

[2025-06-18 12:00:30] Killing process: stress-ng (PID: 1234, RAM: 85%)

----------------To Run as a systemd Service (Recommended)------------

Create a service file:

$sudo nano /etc/systemd/system/system_monitor.service

Paste:
----------------------------------------------------
[Unit]

Description=System Performance Monitor

After=network.target

[Service]

Type=simple

ExecStart=/home/user/scripts/system_monitor.sh

Restart=always

User=root

[Install]

WantedBy=multi-user.target

Start and enable the service:

-----------------------------------------------
To Make Run it Every Time as System Reboot

$sudo systemctl daemon-reload

$sudo systemctl start system_monitor

$sudo systemctl enable system_monitor
