context("reducer tests")

test_that("Simple Assignment", {
  string <- "TEST = 12312
  END"

  dat <- parser$parse(string, lexer)
  res <- reducer(dat)

  expect_length(res, 1)
  expect_equal(res$TEST, 12312)
})

test_that("Simple Assignment", {
  string <- "TEST = 12312
  TEST2 = \"Another string\"
  END"

  dat <- parser$parse(string, lexer)
  res <- reducer(dat)

  expect_length(res, 2)
  expect_equal(res$TEST, 12312)
  expect_equal(res$TEST2, "Another string")
})

test_that("Simple Assignment 3", {
  string <- "TEST = 12312
  TEST2 = \"Another string\"
  TEST3 = 'FACE'
  END"

  dat <- parser$parse(string, lexer)
  res <- reducer(dat)

  expect_length(res, 3)
  expect_equal(res$TEST, 12312)
  expect_equal(res$TEST2, "Another string")
})

test_that("Simple OBJECT", {
  string <- "TEST = 12312
  BEGIN_OBJECT = OBJECT1
    TEST2 = 'INNER'
  END_OBJECT = OBJECT1
  END"

  dat <- parser$parse(string, lexer)
  expect_length(dat, 4)
  res <- reducer(dat)

  expect_length(res, 2)
  expect_equal(res$TEST, 12312)
  expect_equal(res$OBJECT1$TEST2, 'INNER')
})

test_that("Merger Multiple", {
  string1 <- "TEST = 12312
  BEGIN_OBJECT = OBJECT1
    TEST2 = 'INNER'
  END_OBJECT = OBJECT1
  END"
  string2 <- "TEST = 312
  BEGIN_OBJECT = OBJECT1
    TEST2 = 'INNER2'
    TEST3 = 'INNER3'
  END_OBJECT = OBJECT1
  END"
  res <- lapply(c(string1, string2), function(string) {
    dat <- parser$parse(string, lexer)
    res <- reducer(dat)
    res <- t(data.frame(I(res)))
    return(res)
  })
  res <- do.call(rbind.data.frame, res)
  cat("\n")
  str(res)
  cat("\n")
  print(res)
  print(res$TEST)

})
