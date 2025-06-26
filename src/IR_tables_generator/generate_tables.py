# SPDX-FileCopyrightText: Copyright (c) 2022 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
# SPDX-License-Identifier: Apache-2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from openroad_helpers import get_tables_OpenROAD_API
import argparse, os


if __name__ == "__main__":
  parser = argparse.ArgumentParser(description="Options to store the IR tables as .csv files, for a given design name and tech node.")
  parser.add_argument("-d", default="ac97_top", help="Give the design name. Default is ac97_top.")
  parser.add_argument("-t", default="ASAP7", help="Give the technology node. Default is ASAP7.")
  parser.add_argument("-def_file", default="ac97_top_fp.def.gz",  help="Give the def file to be read. Relative path from design directory.")
  parser.add_argument("-guide_file", default="segment_route.guide",  help="Give the segment route guide file generated after global routing. This has to be given only if generating tables for global_route stage. Relative path from design directory.")
  parser.add_argument("-stage", default="floorplan", help="Provide the stage name for which you are generating the IR tables. Default: floorplan. Options: floorplan, placement, global_route")
  parser.add_argument("-out_dir", default="NaN", help="Provide the output directory path to store IR tables. Default is IRs folder inside design directory.")
  args = parser.parse_args() 
  
  print(f"Stage: {args.stage}")
  # Check if design and platform directories exist
  design_dir = "../../designs/" + args.d + "/EDA_files/" 
  platform_dir = "../../platform/" + args.t
  
  if not os.path.isdir(design_dir):
    print(f"Error: Design directory does not exist at {design_dir}")
    os._exit(0)
  else:
    print(f"Design directory : {design_dir}")

  if not os.path.isdir(platform_dir):
    print(f"Error: Platform directory does not exist at {platform_dir}")
    os._exit(0)
  else:
    print(f"Platform directory : {platform_dir}")

  # Check if the def file exists
  def_path = os.path.abspath(design_dir + '/' + args.def_file)
  if not os.path.isfile(def_path):
    print(f"Error: DEF file does not exist at {def_path}")
    os._exit(0)
  else:
    print(f"DEF file : {def_path}")

  guide_path = os.path.abspath(design_dir + '/' + args.guide_file)

  # Check if route guide file exists if stage is 'global_route'
  if args.stage == "global_route":
    if not os.path.isfile(guide_path):
      print(f"Error: Route guide file does not exist at {guide_path}")
      os._exit(0)
    else:
      print(f"Route guide file: {guide_path}")

  IRTables = get_tables_OpenROAD_API("../../", args.def_file, args.guide_file, args.stage, True, args.d, args.t, args.out_dir)
  os._exit(0)
  
