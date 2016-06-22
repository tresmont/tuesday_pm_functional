# NEON Workshop Tuesday Notes

**June 21, 2016**

## LiDAR system

### Discrete
  * Tristan Goulden

Discrete records location of first returns. Results in a smaller data set that is more more easily processed.  But, a lot of intermediate information is lost.

Discrete point clouds are used to generate (linear) interpolated TIN DEM rasters.

NEON produces multiple levels of data
1. Discrete point cloud in LAS format unique to LiDAR
  * ~4 points per m
2. Classified point cloud.
  * Ground, building, vegetation, etc.
3. Digital Surface Model DSM
  * Elevation of all structures (manmade and natural)
4. Digital Terrain model
  * Removes above ground info for assessment of ground.
  * difference between DSM and DTM = canopy height
5. Slope/Aspect
6. Canopy Height model
  * More complex/complete model than simple subtraction.

### Uncertainty
**LAS Tools**

Vertical accuracy data are calibrated using GPS reference points on a known surface (Boulder airport runway).  The runway is flow and imaged with LiDAR.  Results are compared to reference for bias.

Horizontal accuracy is also assessed.  Pulse is recorded at the beam center, which can lead to an offset from the first return that might be on the edge of the beam.  Displacement is measured in a similar way to the vertical in that a known structure is flown and compared to control.

Error assessments are included in an LAZ file.

Generally speaking, LiDAR underestimates canopy height.  This is from canopy penetration before a pulse is returned.

### Full Waveform
  * Keith Krause

The intensity of reflected laser is recorded continuously.

Feature separation is based on the separability of intensity *greater* than the FWHM of the pulse.  FWHM = 10 nsec. ~ 1.5m.  Anything smaller will sum to a single feature.  E.g. tightly spaced branches or tree/bush will not be identifiable individually.

Vegetation is partially discernible. Types (deciduous vs. needle) do not follow a strict form, but might be additive to other analysis. K-means might be able to cluster communities.


### OpenTopography
[OpenTopography](http://opentopography.org/home) offers LiDAR sources and online processing resources.  NSF funded.

Offers tiered delivery of products based on end user requirements and needs; point clouds to derivative maps.

Take data from collectors: Federal (NOAA, NASA, USGS, etc.), Local/state, and NSF funded projects and disseminate to the user community.

This can be a great resource for my project data.  This project really represents the direction many of these big data are headed; Cloud computing doing the heavy lifting with end users accessing the results.


## Git branches

branches allow users to develop new features or ideas without changing the master repo.

Start with a clean status;  All commits up-to-date
`git branch <NEW_BRANCH_NAME>` name of the new branch.  The name is arbitrary, and can be descriptive of what we are working on.
`git branch` to see the branches
`git checkout <NEW_BRANCH_NAME>` changes to the new branch

Example
```
Conquistador:tuesday_pm_functional elm$ git status
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)
nothing to commit, working directory clean
Conquistador:tuesday_pm_functional elm$ git branch refactor
Conquistador:tuesday_pm_functional elm$ git branch
* master
  refactor
Conquistador:tuesday_pm_functional elm$ git checkout refactor
Switched to branch 'refactor'
Conquistador:tuesday_pm_functional elm$ git branch
  master
* refactor
```

to move the branch to remote repo use:

`git push origin <NEW_BRANCH_NAME>`

Once all the work is done on a new branch, we need to merge the new code.
change to the master branch, then merge in the feature branch
example:
```
Conquistador:tuesday_pm_functional elm$ git checkout master
D	16-06-21:145613_sessionInfo.txt
Switched to branch 'master'
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)
Conquistador:tuesday_pm_functional elm$ git merge refactor
Updating a41317e..303e14c
Fast-forward
 raster_functions.Rmd | 150 +++++++++++++++++++++++++----------------------------------------------------------------------------------
 scripts/functions.r  | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+), 116 deletions(-)
 create mode 100644 scripts/functions.r
```
