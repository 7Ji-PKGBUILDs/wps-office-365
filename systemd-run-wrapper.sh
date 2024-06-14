#!/bin/bash
/usr/bin/systemd-run --user --expand-environment=no -- "/usr/lib/wps-office-365/${0##*/}" "$@"