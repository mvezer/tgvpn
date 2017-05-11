#!/bin/bash
cat $(pwd)/torrent_killed.ascii
kill $(pidof tixati)