#!/bin/sh
nc -vz -u 127.0.0.1 ${HEALTCHECK_MONITOR_PORT:-9987}