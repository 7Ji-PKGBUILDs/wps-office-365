#!/bin/bash
/usr/bin/systemd-run --user -- "/usr/lib/wps-office-365/${0##*/}" "$@"