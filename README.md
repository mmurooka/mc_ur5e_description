# UR5e robot description for [mc_rtc](https://jrl-umi3218.github.io/mc_rtc/)
This package has additional convex files for mc_ur5e robot module used by [mc_rtc](https://jrl-umi3218.github.io/mc_rtc/) control framework.
UR5e robot has urdf, collada and meshes in the original [ur_e_description](https://github.com/ros-industrial/universal_robot/tree/kinetic-devel/ur_e_description) package.

It contains the following directories:
 - `convex/`: convex hulls (generated from pointclouds sampled from the dae meshes)
 - `rsdf/`: Special urdf-like format describing surfaces attached to links on the robot (The folder is empty)
 - `urdf/`: Import the [UR5e related urdf](https://github.com/ros-industrial/universal_robot/tree/kinetic-devel/ur_e_description/urdf) file and make partial changes.
   - Conversion from xacro format to urdf format
   - Change the package name (from ur_e_description/meshes/ur5e to mc_aliengo_description/meshes)

## Installation

### ROS environment
On an environment with ROS and catkin properly setup:

```
$ cd ~/catkin_ws/src
$ svn export https://github.com/ros-industrial/universal_robot/branches/kinetic-devel/ur_e_description
    (or '$ git clone https://github.com/ros-industrial/universal_robot.git')
$ git clone https://github.com/@MC_UR5E_DESCRIPTION_REPOSITORY@
$ cd ..
$ catkin_make
```
Execute `convert_from_xacro_to_urdf.sh` to generate ur5e.urdf file.
```
$ @MC_UR5E_DISCRIPTION_PATH@/scripts/convert_from_xacro_to_urdf.sh
```
Then run the following commands.
```
$ cd build
$ make install
```

If your catkin environment is sourced `source ~/catkin_ws/install/setup.bash`, the robot model will be available to all ROS tools, and mc_rtc robot module.

To display the robot, you can use:

```
$ roslaunch mc_ur5e_description display_ur5e.launch
```

 - If you have mc_rtc and the corresponding robot module installed, you can use the `convexes:=True` or `surfaces:=True` arguments to display the robot convexes and surfaces.

### ROS-free environement

If you are on an environment without ROS and catkin, you can still install the robot model such that it is found by the non-ROS packages.

```
$ cd src
$ git clone https://github.com/@MC_UR5E_DESCRIPTION_REPOSITORY@
$ cd @MC_UR5E_DESCRIPTION_PATH@
$ mkdir build
$ cd build
$ cmake ..
$ make
$ sudo make install
```

***

## When updating convex files

### Dependencies

 - [ur_e_description](https://github.com/ros-industrial/universal_robot/tree/kinetic-devel/ur_e_description)
 - [mesh_sampling](https://github.com/arntanguy/mesh_sampling)
 - qhull-bin

### Generation of convex files
To run the conversion, simply run

```
$ source ~/catkin_ws/devel/setup.bash
$ cd ~/catkin_ws/src/@MC_UR5E_DESCRIPTION_PATH@/scripts
$ ./generate_convex.sh
  Running generate_convex.sh script from directory /home/@USERNAME@/catkin_ws/src/@MC_UR5E_DESCRIPTION_PATH@/script
      :
      :
  -- Generating convex hull for /home/@USERNAME@/catkin_ws/install/share/ur_e_description/meshes/ur5e/collision/upperarm.stl
  -- Generating convex hull for /home/@USERNAME@/catkin_ws/install/share/ur_e_description/meshes/ur5e/collision/forearm.stl
  -- Generating convex hull for /home/@USERNAME@/catkin_ws/install/share/ur_e_description/meshes/ur5e/collision/base.stl
  -- Generating convex hull for /home/@USERNAME@/catkin_ws/install/share/ur_e_description/meshes/ur5e/collision/wrist2.stl
  -- Generating convex hull for /home/@USERNAME@/catkin_ws/install/share/ur_e_description/meshes/ur5e/collision/wrist3.stl
  -- Generating convex hull for /home/@USERNAME@/catkin_ws/install/share/ur_e_description/meshes/ur5e/collision/shoulder.stl
  -- Generating convex hull for /home/@USERNAME@/catkin_ws/install/share/ur_e_description/meshes/ur5e/collision/wrist1.stl

  Successfully generated convex from ur_e_description package in /tmp/mc_ur5e_description

$ mv /tmp/mc_ur5e_description/convex/ur5e ~/catkin_ws/src/@MC_UR5E_DESCRIPTION_PATH@/convex/.
```
