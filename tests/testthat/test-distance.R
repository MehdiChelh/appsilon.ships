test_that("distance calculation", {
  expect_type(haversine_dist, "closure")
  # Check that calculation is okay
  dist <- haversine_dist(1, 1, 0, 0)
  expect_equal(round(dist, 2), 157422.16)
})

test_that("longest_distance", {
  expect_type(longest_distance, "closure")
  dist <- longest_distance(ships, "KAROLI")
  # Check that longest_distance result has the right format
  expect_true(all(
    colnames(dist) %in%
      c(
        "lat2",
        "long2",
        "datetime2",
        "lat1",
        "long1",
        "datetime1",
        "distance"
      )
  ))
  # Check that distance is okay
  expect_equal(round(dist$distance, 2), 3098.12)
})
