reduce <- function(dat) {
  obj_stack <- list(list())
  name_stack <- c()
  # Assign a value

  for (i in seq_along(dat)) {
    cmd <- dat[[i]]
    # cat(sprintf("\n[%03d:%d:%d]\t%s #%s#", i, length(obj_stack),
    #             length(name_stack), cmd$action, cmd$name))
    if (cmd$action == 'assignment') obj_stack[[length(obj_stack)]][[cmd$name]] <- cmd$value
    else if (cmd$action == 'group_start') {
      obj_stack[[length(obj_stack) + 1]] <- list()
      name_stack <- c(cmd$name, name_stack)
    } else if (cmd$action == 'group_end') {
      # Check if there is already a object...
      assign_pos <- length(obj_stack) - 1
      obj_name <- name_stack[1]
      if (!is.null(obj_stack[[assign_pos]][[obj_name]])) {
        # existing assignment is not a list or is a list with named objects,
        # assume we need a new list
        if (typeof(obj_stack[[assign_pos]][[obj_name]]) != "list" ||
            !is.null(names(obj_stack[[assign_pos]][[obj_name]]))) {
          obj_stack[[assign_pos]][[obj_name]] <- list(
            obj_stack[[assign_pos]][[obj_name]],
            obj_stack[[length(obj_stack)]])
        } else if (is.null(names(obj_stack[[assign_pos]][[obj_name]]))) {
          obj_stack[[assign_pos]][[obj_name]][[length(obj_stack[[assign_pos]][[obj_name]])
                                               + 1]] <- obj_stack[[length(obj_stack)]]
        } else {
          message("ERROR: How?")
        }
      } else {
        obj_stack[[assign_pos]][[obj_name]] <- obj_stack[[length(obj_stack)]]
      }
      # Drop the 'top' of the stacks
      obj_stack <- obj_stack[1:length(obj_stack) - 1]
      if (length(name_stack) > 1) {
        name_stack <- name_stack[2:length(name_stack)]
      } else {
        name_stack <- c()
      }
    } else if (cmd$action == 'pointer') {
      obj_stack[[length(obj_stack)]][[cmd$name]] <- list(value = cmd$value, offset = cmd$offset)
    }
  }

  return(obj_stack[[1]])
}
