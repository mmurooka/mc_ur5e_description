cmake_minimum_required(VERSION 2.8.3)
project(mc_ur5e_description)

find_package(catkin REQUIRED COMPONENTS
  ur_description
)

if("${ur_description_INSTALL_PREFIX}" STREQUAL "")
  if("${ur_description_SOURCE_PREFIX}" STREQUAL "")
    message(FATAL_ERROR "ur_description does not provide SOURCE_PREFIX or INSTALL_PREFIX")
  else()
   set(ur_description_PREFIX "${ur_description_SOURCE_PREFIX}")
  endif()
else()
  set(ur_description_PREFIX "${ur_description_INSTALL_PREFIX}/share/ur_description")
endif()

set(DATA_INSTALL_FOLDER "${CMAKE_INSTALL_PREFIX}/share/${PROJECT_NAME}")

set(xacro_IN
  ${ur_description_PREFIX}/urdf/ur5e.xacro
)

set(xacro_SRC
  ${xacro_IN}
  ${ur_description_PREFIX}/urdf/inc/ur_common.xacro
  ${ur_description_PREFIX}/urdf/inc/ur_macro.xacro
  ${ur_description_PREFIX}/urdf/inc/ur_transmissions.xacro
  ${ur_description_PREFIX}/config/ur5e/joint_limits.yaml
  ${ur_description_PREFIX}/config/ur5e/default_kinematics.yaml
  ${ur_description_PREFIX}/config/ur5e/physical_parameters.yaml
  ${ur_description_PREFIX}/config/ur5e/visual_parameters.yaml
)

find_program(XACRO xacro REQUIRED)
set(urdf_OUT "${CMAKE_CURRENT_SOURCE_DIR}/urdf/ur5e.urdf")
add_custom_command(
  OUTPUT ${urdf_OUT}
  COMMAND ${XACRO} -i ${xacro_IN} -o ${urdf_OUT}
  DEPENDS ${xacro_SRC}
  COMMENT "Generate ${urdf_OUT}"
)
add_custom_target(generate-mc-ur5e-urdf ALL DEPENDS ${urdf_OUT})
install(FILES "${URDF_OUT}" DESTINATION ${DATA_INSTALL_FOLDER}/urdf/)

install(DIRECTORY convex rsdf DESTINATION ${DATA_INSTALL_FOLDER})

catkin_package()
