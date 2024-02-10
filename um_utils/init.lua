um_utils = {}

-- For backend.canonical_name
-- Return the lowercase of all given account names
-- => Case-insensitive backend
um_utils.backend_case_insensitive = function(name)
    return string.lower(name)
end
