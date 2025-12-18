#!/usr/bin/env python3

import getpass
import json
import sys

import pandas as pd
import requests

print("""
Terraform Cloud - Fetch All Workspaces Current State Versions
""")

# Token/Password input in a terminal
try:
    TFC_TOKEN = getpass.getpass()
    if TFC_TOKEN == "":
        print("Detected no Token input ")
        sys.exit()
except Exception as e:
    print(e)

# HTTP headers
httpH = {
    "Authorization": "Bearer %s" % TFC_TOKEN,
    "Content-Type": "application/json",
}

# TFC EndPoint
URL = "https://app.terraform.io/api/v2/organizations/stash/workspaces?page=100"

# Mushed JSON List
merged_set = []


# Merge JSON objects
def merge_main_request():
    Main_Req = requests.get(URL, headers=httpH)
    raw = Main_Req.json()
    for workspaces in raw["data"]:
        merged_set.append(workspaces)
    while raw["links"]["first"] != raw["links"]["last"]:
        if (raw["links"]["next"]) == None:
            break
        else:
            next_Req = requests.get(raw["links"]["next"], headers=httpH)
            raw = next_Req.json()
            for workspaces in raw["data"]:
                merged_set.append(workspaces)
    return merged_set


# Get WorkSpaces with saved state
def saved_states():
    states_list = []
    for pg in merge_main_request():
        if (pg["relationships"]["current-state-version"]["data"]) is None:
            # Ignore workspaces currently with no states saved
            continue
        else:
            # StatesReq
            SReq = requests.get(
                "https://app.terraform.io"
                + pg["relationships"]["current-state-version"]["links"]["related"],
                headers=httpH,
            ).json()
            char = {
                "NameSpace": pg["attributes"]["name"],
                "StateVersion": SReq["data"]["attributes"]["terraform-version"],
                "TerraformVersion": pg["attributes"]["terraform-version"],
            }
            states_list.append(char)
    return states_list


# Load saved_states into a Pandas DataFrame
df = pd.DataFrame(saved_states())

# Load Pandas DataFrame into a CSV file
df.to_csv("CurrentWorkspacesStateVersions.csv", index=False)
