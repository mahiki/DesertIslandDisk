DesertIslandDisk.jl
===================

Tools I personally use all the time. Generally a data science vibe.

Installation at REPL:

```jl
# from a locally cloned repo
pkg> add ~/repo/julia-pkgs/DesertIslandDisk

# or from the remote repo
pkg> add https://github.com/mahiki/DesertIslandDisk

julia> using DesertIslandDisk
```


### read_partitioned_dataframe_csv
Data ingestion tools like Parquet.jl and CSV.jl do not yet support reading partitioned datasets, of the type you might find as outputs of Redshift unload, Spark write to disk, or the like.  This is a first draft minimal working version, currently only configured to read csv but easily changed. 

I expect to roll the partitioned reader out into its own package, but at least a working technique is available now.

Supported:

* s3 or local file system paths
* nested partitions like Redshift unload or spark write
* files with ".csv" extensions only so far

Not yet supported:

* partition pruning (filtering partitions before reading)
* detecting file type
* parquet files
* detecting column_type of partition columns the way CSV does

Example:

```jl
#=  
taxi_dataset is tabular csv of tab delimited columns containing a date field

s3://data-bucket/taxi_dataset/
    report_day=2021-01-06/
        region=NA/
        region=EU/
        region=SA/
    report_day=2021-01-07/
        ..etc
=#

using DesertIslandDisk, AWS, AWSS3

aws = global_aws_config(; region = "us-east-1")

date_partitioned_root = "s3://data-bucket/taxi_dataset"

df = read_partitioned_dataframe_csv(
        S3Path(date_partitioned_root, config = aws)
        , "yyyy-mm-dd"
        , Dict(:report_day => Date)
        )
