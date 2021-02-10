#!/bin/bash
################################################################################
##  File:  install-helpers.sh
##  Desc:  Helper functions for installing tools
################################################################################

function isUbuntu16
{
    lsb_release -d | grep -q 'Ubuntu 16'
}

function isUbuntu18
{
    lsb_release -d | grep -q 'Ubuntu 18'
}

function isUbuntu20
{
    lsb_release -d | grep -q 'Ubuntu 20'
}

function getOSVersionLabel
{
    lsb_release -cs
}