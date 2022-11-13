#!/bin/bash

TMP_URDF=/tmp/ur5e.urdf

source ~/catkin_ws/devel/setup.bash

# Change current directory
roscd ur_e_description

# Convert from xacro to urdf file
xacro ./urdf/ur5e_robot.urdf.xacro > ${TMP_URDF}

# Replace package name
sed -i -e "s/ur_e_description\/meshes\/ur5e/mc_ur5e_description\/meshes/g" ${TMP_URDF}

# Move to project source
roscd mc_ur5e_description
if [ ! -d urdf ]; then
  mkdir urdf
fi
mv ${TMP_URDF} urdf/.
