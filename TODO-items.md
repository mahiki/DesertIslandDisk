# TODO

## read_partitioned_dataframe_csv
TODO: add AWS as explicit dependency
TODO: default args date_format = nothing, column_types = nothing, call CSV.read as kwargs
TODO: explicitly list Union type of S3Path/Abs Path, make note that AWSConfig is component of S3Path
TODO: ["csv", "txt", "tsv"] extensions should be OK, add as vector membership check
TODO: spin off PartitionedDataReader.jl to a repo

