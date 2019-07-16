#!/usr/bin/python

import json
import subprocess


outputs_json = subprocess.check_output(["swaymsg", "-t", "get_outputs"])
outputs = json.loads(outputs_json)

workspaces_json = subprocess.check_output(["swaymsg", "-t", "get_workspaces"])
workspaces = json.loads(workspaces_json)

for output in outputs:
    if output["focused"]:
        focused_output = output
        break
else:
    raise Exception("No focused outputs")


for workspace in workspaces:
    if workspace["output"] != focused_output["name"]:
        move_ws_args = [
            "swaymsg",
            '[workspace="{}"]'.format(workspace["name"]),
            "move",
            "workspace",
            "to",
            "output",
            output["name"],
        ]
        subprocess.check_call(move_ws_args)

refocus_ws_args = ["swaymsg", "workspace", focused_output["current_workspace"]]
subprocess.check_call(refocus_ws_args)
