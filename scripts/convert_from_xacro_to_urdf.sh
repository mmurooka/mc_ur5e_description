#!/bin/bash

MC_UR5E_DESCRIPTION_PATH=`rospack find mc_ur5e_description`
UR_DESCRIPTION_PATH=`rospack find ur_description`

# Convert xacro to urdf
TMP_URDF=/tmp/ur5e.urdf
xacro ${UR_DESCRIPTION_PATH}/urdf/ur5e.xacro > ${TMP_URDF}

# Copy meshes
cp -r ${UR_DESCRIPTION_PATH}/meshes/ur5e ${MC_UR5E_DESCRIPTION_PATH}/meshes
sed -i -e "s@ur_description/meshes/ur5e@mc_ur5e_description/meshes@g" ${TMP_URDF}

# Move to project source
URDF_DIR=${MC_UR5E_DESCRIPTION_PATH}/urdf
if [ ! -d ${URDF_DIR} ]; then
  mkdir -p ${URDF_DIR}
fi
mv ${TMP_URDF} ${URDF_DIR}
