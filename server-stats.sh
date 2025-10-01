#!/bin/bash

echo "================= SERVER PERFORMANCE STATS ================="
echo "Generated on: $(date)"
echo "Hostname: $(hostname)"
echo "-------------------------------------------------------------"

# 1. CPU Usage
echo ""
echo ">>> CPU USAGE:"
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')
echo "Total CPU Usage: $CPU_USAGE"

# 2. Memory Usage
echo ""
echo ">>> MEMORY USAGE:"
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_FREE=$(free -m | awk '/Mem:/ {print $4}')
MEM_PERCENT=$(free | awk '/Mem:/ {printf("%.2f"), $3/$2 * 100.0}')
echo "Total: ${MEM_TOTAL}MB | Used: ${MEM_USED}MB | Free: ${MEM_FREE}MB | Usage: ${MEM_PERCENT}%"

# 3. Disk Usage
echo ""
echo ">>> DISK USAGE:"
df -h --total | grep 'total' | awk '{print "Total: "$2" | Used: "$3" | Free: "$4" | Usage: "$5}'

# 4. Top 5 Processes by CPU Usage
echo ""
echo ">>> TOP 5 PROCESSES BY CPU USAGE:"
ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu | head -n 6

# 5. Top 5 Processes by Memory Usage
echo ""
echo ">>> TOP 5 PROCESSES BY MEMORY USAGE:"
ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%mem | head -n 6

echo "-------------------------------------------------------------"
echo "End of report."
